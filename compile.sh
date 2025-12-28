#!/bin/bash
#
# IEEJ LaTeX Compilation Script (LuaLaTeX default)
#

ENGINE="lualatex"
TEXFILE="template-j"
RUNS=2
INSTALL_DEPS=false

usage() {
    echo "Usage: $0 [-e engine] [-f texfile] [-r runs] [-i]"
    echo "  -e engine   : lualatex (default), uplatex, platex"
    echo "  -f texfile  : TeX filename without extension"
    echo "  -r runs     : Number of compilation runs (default: 2)"
    echo "  -i          : Install required TeX packages (requires sudo)"
    exit 0
}

while getopts "e:f:r:ih" opt; do
    case $opt in
        e) ENGINE="$OPTARG" ;;
        f) TEXFILE="$OPTARG" ;;
        r) RUNS="$OPTARG" ;;
        i) INSTALL_DEPS=true ;;
        h) usage ;;
    esac
done

# Install dependencies if requested
if $INSTALL_DEPS; then
    echo "=== Installing required TeX packages ==="
    sudo apt-get update
    sudo apt-get install -y \
        texlive-lang-japanese \
        texlive-luatex \
        texlive-fonts-extra \
        texlive-plain-generic
    echo ""
fi

TEXFILE="${TEXFILE%.tex}"

echo "=== IEEJ LaTeX Compilation ==="
echo "Engine: $ENGINE | File: ${TEXFILE}.tex"
echo ""

case "$ENGINE" in
    "lualatex")
        for i in $(seq 1 $RUNS); do
            echo "--- lualatex run $i/$RUNS ---"
            lualatex -interaction=nonstopmode "${TEXFILE}.tex" || exit 1
        done
        ;;
    "uplatex")
        for i in $(seq 1 $RUNS); do
            uplatex -interaction=nonstopmode -kanji=utf8 "${TEXFILE}.tex" || exit 1
        done
        dvipdfmx "${TEXFILE}.dvi"
        ;;
    "platex")
        for i in $(seq 1 $RUNS); do
            platex -interaction=nonstopmode "${TEXFILE}.tex" || exit 1
        done
        dvipdfmx "${TEXFILE}.dvi"
        ;;
esac

echo "=== Done: ${TEXFILE}.pdf ==="
