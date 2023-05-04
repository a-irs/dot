# Makefile

MAKEFLAGS += -j $(shell nproc)

dest := _output

all: pdf html md
pdf: $(dest)/main.pdf
html: $(dest)/main.html
md: $(dest)/main.md

src := *.qmd content/* assets/* _extensions/*/* _quarto.yml
$(dest)/main.pdf: $(src)
	quarto render --to pdf
$(dest)/main.html: $(src)
	quarto render --to html
$(dest)/main.md: $(src)
	quarto render --to markdown

watch:
	ls $(src) | entr make $$TARGET

clean:
	rm -rfv $(dest)/
