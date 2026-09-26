# Tests

Register of all tests, sorted by the [FEATURES.md](FEATURES.md) number each test covers. `npm test` runs everything; the guard `tests/docs-contract.sh` fails when a feature has no test entry here.

## E2E (`tests/run-e2e.sh`)

- **F1** pdflatex_succeeds, pdf_written — `pdflatex` compiles the sample to a PDF.
- **F1** one_page_with_hyperref — the sample with `hyperref` becomes one page, so the packages of the distribution are found.
- **F2** pdflatex_succeeds — the same command line as the `command` of `docker-compose.yaml`, on `doc/sample.tex` in `/doc`.
- **F3** runs_unprivileged — the PDF belongs to `somebody`.

## Image contract

- **F4** `tests/image-contract.sh` › no sh, no bash, no busybox, no perl — the image is headless.

## Workflow contract

- **F5** `tests/workflow-contract.sh` of `mwaeckerlin/scratch` — the reusable workflow selects exactly the images a repository publishes; this repository calls it from `.github/workflows/docker.yml`.
