#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
#  Build script for "Theory of Quantum Noise and Decoherence"
# ──────────────────────────────────────────────────────────────
set -euo pipefail

LATEX_DIR="$(cd "$(dirname "$0")/latex" && pwd)"
MAIN="QuantumNoiseAndDecoherence"
ENGINE="xelatex"
ENGFLAGS="-interaction=nonstopmode -halt-on-error"

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --cmfonts    Use Computer Modern fonts (no proprietary fonts)
  --draft      Single pass only (fast)
  --full       Full build (3 passes + bibtex)
  --clean      Remove generated files
  -h, --help   Show this help
EOF
}

do_clean() {
  cd "$LATEX_DIR"
  rm -f "$MAIN".{aux,bbl,blg,log,out,toc,pdf,synctex.gz,fls,fdb_latexmk}
  rm -f lectures/*.aux
  echo "Cleaned."
}

do_build() {
  local passes="${1:-3}"
  local extra_flags="${2:-}"
  cd "$LATEX_DIR"

  echo "=== Pass 1 ==="
  $ENGINE $ENGFLAGS $extra_flags "$MAIN.tex"

  if [ "$passes" -ge 2 ]; then
    echo "=== BibTeX ==="
    bibtex "$MAIN" || true
    echo "=== Pass 2 ==="
    $ENGINE $ENGFLAGS $extra_flags "$MAIN.tex"
  fi

  if [ "$passes" -ge 3 ]; then
    echo "=== Pass 3 ==="
    $ENGINE $ENGFLAGS $extra_flags "$MAIN.tex"
  fi

  echo "=== Done: ${MAIN}.pdf ==="
}

# ── Parse arguments ──────────────────────────────────────
CM_FLAG=""
case "${1:-full}" in
  --cmfonts)  CM_FLAG="\PassOptionsToPackage{cmfonts}{qnd-style}"; do_build 3 "$CM_FLAG" ;;
  --draft)    do_build 1 ;;
  --full)     do_build 3 ;;
  --clean)    do_clean ;;
  -h|--help)  usage ;;
  *)          usage; exit 1 ;;
esac
