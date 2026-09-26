#!/usr/bin/env bash
# E2E: the image compiles doc/sample.tex to a PDF, as the unprivileged user,
# in a directory that belongs to that user — the way the README uses it.
# A named volume stands in for the host directory.
# Usage: bash tests/run-e2e.sh
set -uo pipefail

cd "$(dirname "$0")/.."
IMAGE="mwaeckerlin/latex"
VOLUME="latex-e2e-doc"

cleanup() { docker volume rm -f "${VOLUME}" > /dev/null 2>&1 || true; }
trap cleanup EXIT

PASS=0
FAIL=0
_pass() { PASS=$((PASS + 1)); echo "  PASS  $1"; }
_fail() { FAIL=$((FAIL + 1)); echo "  FAIL  $1: $2"; }
_doc() { docker run --rm -i -v "${VOLUME}:/doc" mwaeckerlin/very-base sh -c "$1"; }

echo "==> E2E: compile a document"
cleanup
docker volume create "${VOLUME}" > /dev/null
_doc 'cat > /doc/sample.tex && chown -R somebody:somebody /doc' < doc/sample.tex

OUT=$(docker run --rm --pull=never -v "${VOLUME}:/doc" -w /doc "${IMAGE}" pdflatex -interaction=nonstopmode sample.tex 2>&1)
RC=$?
if [[ ${RC} -eq 0 ]]; then _pass "pdflatex_succeeds"; else _fail "pdflatex_succeeds" "rc=${RC}: ${OUT: -800}"; fi

if [[ "$(_doc 'head -c 5 /doc/sample.pdf' 2>/dev/null)" == "%PDF-" ]]; then
    _pass "pdf_written"
else
    _fail "pdf_written" "no /doc/sample.pdf"
fi
if [[ "${OUT}" == *"Output written on sample.pdf (1 page"* ]]; then
    _pass "one_page_with_hyperref"
else
    _fail "one_page_with_hyperref" "${OUT: -400}"
fi
OWNER=$(_doc 'stat -c %U /doc/sample.pdf' 2>/dev/null)
if [[ "${OWNER}" == "somebody" ]]; then _pass "runs_unprivileged"; else _fail "runs_unprivileged" "PDF belongs to '${OWNER}'"; fi

echo ""
echo "==> E2E results: ${PASS} passed, ${FAIL} failed"
[[ ${FAIL} -eq 0 ]] || exit 1
