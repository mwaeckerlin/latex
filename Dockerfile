FROM mwaeckerlin/very-base AS latex-build
USER root
RUN $PKG_INSTALL \
    texlive-full \
    texmf-dist-latexrecommended \
    texmf-dist-latexextra \
    texmf-dist-bibtexextra
COPY tex/vorstoss.cls /usr/share/texmf-dist/tex/latex/vorstoss/
COPY tex/logo.png /usr/share/texmf-dist/tex/latex/vorstoss/
RUN texhash 
#/usr/share/texmf-dist
RUN for file in \
        /usr/bin/pdflatex \
        /usr/share/texmf-dist \
        /usr/share/texmf-var \
        /usr/share/tlpkg \
        $(ldd /usr/bin/pdflatex | sed -n 's,.* \([^ ]*/lib/[^ ]*\) .*,\1,p'); \
    do \
        path=${file%/*}; \
        test -d /tmp/root/$path || mkdir -p /tmp/root/$path; \
        cp -Lr $file /tmp/root/$file; \
    done

FROM mwaeckerlin/scratch AS latex
COPY --from=latex-build /tmp/root /
