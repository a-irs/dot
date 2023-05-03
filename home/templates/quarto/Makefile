# Makefile

MAKEFLAGS += "-j $(shell nproc)"

all: pdf html md

pdf: _output/index.pdf
html: _output/index.html
tex: _output/index.tex
md: _output/index.md


_output/index.pdf: index.md content/* assets/* _quarto.yml
	quarto render --to pdf

_output/index.html: index.md content/* assets/* _quarto.yml
	quarto render --to html

_output/index.tex: index.md content/* assets/* _quarto.yml
	quarto render --to latex

_output/index.md: index.md content/* assets/* _quarto.yml
	quarto render --to markdown


watch:
	ls *.md content/* assets/* _quarto.yml | entr make $$TARGET

clean:
	rm -rfv _output/
