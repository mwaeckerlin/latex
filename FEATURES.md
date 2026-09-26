# Features

Numbered register of every feature; a number is never reused. Every feature is covered by tests listed in [TESTS.md](TESTS.md); the guard `tests/docs-contract.sh` fails when a feature has no test.

- **F1 — Compile LaTeX to PDF.** `pdflatex` with the complete TeX Live distribution of Alpine (`texlive-full` with the recommended, extra and BibTeX extra packages) compiles a document in the working directory to PDF.
- **F2 — Compile a directory with docker compose.** `docker compose up` compiles `doc/sample.tex` to `doc/sample.pdf`; another document is compiled by changing the `command`.
- **F3 — Unprivileged.** `pdflatex` runs as `somebody`, so the PDF belongs to that user and the directory has to be writable for it.
- **F4 — Headless.** Only `pdflatex`, its libraries and the TeX tree are in the image: no shell, no package manager.
- **F5 — Published for amd64 and arm64.** Every push builds the image natively for both architectures and publishes it under one tag on Docker Hub, with the reusable workflow of `mwaeckerlin/scratch`.
