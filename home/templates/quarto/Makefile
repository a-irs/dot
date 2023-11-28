# Makefile

NAME = TODO

MAKEFLAGS += -j $(shell nproc)

dest := .output

all: pdf html md
pdf: $(dest)/$(NAME).pdf
html: $(dest)/$(NAME).html
md: $(dest)/$(NAME).md

src := *.md content/* _extensions/*/* _quarto.yml
$(dest)/$(NAME).pdf: $(src)
	quarto render --to pdf --output $(NAME).pdf
$(dest)/$(NAME).html: $(src)
	quarto render --to html --output $(NAME).html
$(dest)/$(NAME).md: $(src)
	quarto render --to commonmark_x --output $(NAME).md

watch:
	ls $(src) | entr make $$TARGET

clean:
	rm -rfv $(dest)/ .quarto/
