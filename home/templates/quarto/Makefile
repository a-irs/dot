# Makefile

MAKEFLAGS += -j $(shell nproc)

dest := .output

all: pdf html md
pdf: $(dest)/main.pdf
html: $(dest)/main.html
md: $(dest)/main.commonmark_x.md

src := *.md content/* assets/* _extensions/*/* _quarto.yml
$(dest)/main.pdf: $(src)
	quarto render --to pdf
$(dest)/main.html: $(src)
	quarto render --to html
$(dest)/main.commonmark_x.md: $(src)
	quarto render --to commonmark_x

watch:
	ls $(src) | entr make $$TARGET

clean:
	rm -rfv $(dest)/ .quarto/
