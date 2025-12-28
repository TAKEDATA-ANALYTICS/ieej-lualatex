# latexmkrc - LuaLaTeX configuration for IEEJ
#
# Required packages (Ubuntu/Debian):
#   sudo apt-get install texlive-lang-japanese texlive-luatex \
#                        texlive-fonts-extra texlive-plain-generic
#
# Usage:
#   latexmk template-j        # Compile
#   latexmk -pvc template-j   # Continuous preview mode

$pdf_mode = 4;  # LuaLaTeX
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';
$max_repeat = 5;

# Alternative: upLaTeX (uncomment below, comment above)
# $pdf_mode = 3;
# $latex = 'uplatex -synctex=1 -interaction=nonstopmode -kanji=utf8 %O %S';
# $dvipdf = 'dvipdfmx %O -o %D %S';
