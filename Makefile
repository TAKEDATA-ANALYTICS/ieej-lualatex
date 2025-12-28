# IEEJ LaTeX Makefile (LuaLaTeX default)
#
# Usage:
#   make deps         - Install required TeX packages (run once)
#   make              - Compile with lualatex
#   make uplatex      - Compile with uplatex
#   make clean        - Remove auxiliary files

TEXFILE = template-j
RUNS = 2

# Required packages for IEEJ class
PACKAGES = texlive-lang-japanese texlive-luatex texlive-fonts-extra texlive-plain-generic

.PHONY: all deps lualatex uplatex platex clean distclean

all: lualatex

# Install required TeX packages (Ubuntu/Debian)
deps:
	sudo apt-get update
	sudo apt-get install -y $(PACKAGES)

lualatex: $(TEXFILE).tex ieej.cls
	@for i in $$(seq 1 $(RUNS)); do \
		echo "--- lualatex run $$i/$(RUNS) ---"; \
		lualatex -interaction=nonstopmode $(TEXFILE).tex || exit 1; \
	done
	@echo "=== Done: $(TEXFILE).pdf ==="

uplatex: $(TEXFILE).tex ieej.cls
	@for i in $$(seq 1 $(RUNS)); do \
		uplatex -interaction=nonstopmode -kanji=utf8 $(TEXFILE).tex || exit 1; \
	done
	dvipdfmx $(TEXFILE).dvi

platex: $(TEXFILE).tex ieej.cls
	@for i in $$(seq 1 $(RUNS)); do \
		platex -interaction=nonstopmode $(TEXFILE).tex || exit 1; \
	done
	dvipdfmx $(TEXFILE).dvi

clean:
	rm -f $(TEXFILE).aux $(TEXFILE).log $(TEXFILE).dvi $(TEXFILE).out \
	      $(TEXFILE).toc $(TEXFILE).synctex.gz

distclean: clean
	rm -f $(TEXFILE).pdf

git: clean
	git add . && \
	git commit -m "$(shell hostname)" && \
	git push
