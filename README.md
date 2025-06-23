# Minimal LaTeX Docker Image

This project provides a minimal, reproducible LaTeX environment in a Docker container, following the philosophy of [mwaeckerlin/very-base](https://github.com/mwaeckerlin/very-base), [mwaeckerlin/nodejs](https://github.com/mwaeckerlin/nodejs), and [mwaeckerlin/nginx](https://github.com/mwaeckerlin/nginx):

- **Minimalism:** Only the required binaries and files are included in the final image.
- **Security:** Runs as non-root, no shell or package manager in the runtime image.
- **Multi-stage builds:** Build in a larger image, copy only the output and dependencies into a minimal runtime image.
- **Reproducibility:** Consistent, predictable builds and outputs.

## Usage

1. Place your LaTeX source (e.g., `sample.tex`) in the `doc/` directory.
2. Run `docker compose up` to build the image and compile the LaTeX file to PDF.
3. The resulting `sample.pdf` will be available in the `doc/` directory.

## Example

A sample document is provided in `doc/sample.tex`. On `docker compose up`, it will be compiled to `doc/sample.pdf`.

---

**License:** LGPL-3.0 