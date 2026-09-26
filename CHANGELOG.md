# Changelog

- 2026-09-26 **1.0.1**
    - The image is published for amd64 and arm64 under one tag, built and published automatically on every change and every week
    - The project carries the npm commands of the family (`npm run build`, `npm start`, `npm test`), and `npm test` compiles the sample document and checks that the image has no shell

- 2025-06-24 **1.0.0**
    - Minimal LaTeX image: `pdflatex` with the complete TeX Live distribution, running as the unprivileged user, without shell and package manager
    - `docker compose up` compiles `doc/sample.tex` to `doc/sample.pdf`
