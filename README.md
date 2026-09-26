# Minimal LaTeX Docker Image

This project provides a minimal, reproducible LaTeX environment in a Docker container, following the philosophy of [mwaeckerlin/very-base](https://github.com/mwaeckerlin/very-base), [mwaeckerlin/nodejs](https://github.com/mwaeckerlin/nodejs), and [mwaeckerlin/nginx](https://github.com/mwaeckerlin/nginx):

- **Minimalism:** Only `pdflatex`, its libraries and the complete TeX Live tree are included in the final image.
- **Security:** Runs as non-root, no shell or package manager in the runtime image.
- **Multi-stage builds:** Build in a larger image, copy only the output and dependencies into a minimal runtime image.
- **Reproducibility:** Consistent, predictable builds and outputs.
- **Architectures:** Published for `linux/amd64` and `linux/arm64`.

## Usage

1. Place your LaTeX source (e.g., `sample.tex`) in the `doc/` directory.
2. Run `docker compose up` to build the image and compile the LaTeX file to PDF.
3. The resulting `sample.pdf` will be available in the `doc/` directory.

`pdflatex` runs as the unprivileged user `somebody`, so the `doc/` directory must be writable for that user. Another document is compiled by changing the `command` in `docker-compose.yaml`, e.g. `pdflatex -interaction=nonstopmode letter.tex`.

## Example

A sample document is provided in `doc/sample.tex`. On `docker compose up`, it will be compiled to `doc/sample.pdf`.

## Development

```bash
$ npm run build
$ npm test
```

`npm test` checks the feature register ([FEATURES.md](FEATURES.md), [TESTS.md](TESTS.md)), the headless image contract and compiles the sample document in a volume. The image is built and published by the reusable workflow of [mwaeckerlin/scratch](https://github.com/mwaeckerlin/scratch#publishing-on-docker-hub).
