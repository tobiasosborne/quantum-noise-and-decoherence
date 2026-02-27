#!/usr/bin/env bash
#
# build.sh — Build automation for Theory of Quantum Noise and Decoherence
#
# Usage:
#   ./build.sh              Full build (3 passes + bibtex)
#   ./build.sh --draft      Single pass (fast)
#   ./build.sh --cmfonts    Computer Modern fonts (portable)
#   ./build.sh --clean      Remove generated files
#   ./build.sh --watch      Continuous build on file change

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LATEX_DIR="$SCRIPT_DIR/latex"
MAIN="QuantumNoiseAndDecoherence"

# Default flags
CMFONTS=""
DRAFT=false

# ── Parse arguments ───────────────────────────────────────────
ACTION="${1:---build}"

case "$ACTION" in
  --draft)    DRAFT=true ;;
  --cmfonts)  CMFONTS="\\PassOptionsToPackage{cmfonts}{qnd-style}" ;;
  --clean)
    echo "Cleaning generated files..."
    cd "$LATEX_DIR"
    rm -f *.aux *.log *.bbl *.blg *.out *.toc *.pdf *.synctex.gz *.fls *.fdb_latexmk
    rm -f lectures/*.aux
    echo "Done."
    exit 0
    ;;
  --watch)
    echo "Watching for changes... (Ctrl-C to stop)"
    cd "$LATEX_DIR"
    while true; do
      inotifywait -q -e modify -r . --include '\.tex$|\.sty$|\.bib$' 2>/dev/null
      echo "Change detected, rebuilding..."
      "$0" --draft || true
      echo "Waiting for next change..."
    done
    ;;
  -h|--help)
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --cmfonts    Use Computer Modern fonts (no proprietary fonts)
  --draft      Single pass only (fast)
  --clean      Remove generated files
  --watch      Continuous build on file change
  -h, --help   Show this help
EOF
    exit 0
    ;;
  --build|*)
    ;;
esac

# ── Build main document ──────────────────────────────────────
cd "$LATEX_DIR"
echo "Building ${MAIN}.pdf..."

if $DRAFT; then
  echo "  [draft mode — single pass]"
  xelatex -interaction=nonstopmode -halt-on-error $CMFONTS "$MAIN.tex"
else
  echo "  [full mode — 3 passes + bibtex]"
  xelatex -interaction=nonstopmode -halt-on-error $CMFONTS "$MAIN.tex"
  bibtex "$MAIN" || true
  xelatex -interaction=nonstopmode -halt-on-error $CMFONTS "$MAIN.tex"
  xelatex -interaction=nonstopmode -halt-on-error $CMFONTS "$MAIN.tex"
fi

echo "Done: ${MAIN}.pdf"
