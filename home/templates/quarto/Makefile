# Makefile

NAME = TODO

MAKEFLAGS += -j $(shell nproc)

dest := .output

all: pdf html md tex docx odt

pdf: $(dest)/$(NAME).pdf
html: $(dest)/$(NAME).html
md: $(dest)/$(NAME).md
tex: $(dest)/$(NAME).tex
docx: $(dest)/$(NAME).docx
odt: $(dest)/$(NAME).odt

src := *.md content/* _extensions/*/* _quarto.yml Makefile

$(dest)/$(NAME).pdf: $(src)
	quarto render --to pdf --output $(NAME).pdf
$(dest)/$(NAME).html: $(src)
	quarto render --to html --output $(NAME).html
$(dest)/$(NAME).md: $(src)
	quarto render --to commonmark_x --output $(NAME).md
$(dest)/$(NAME).tex: $(src)
	quarto render --to latex --output $(NAME).tex
$(dest)/$(NAME).docx: $(src)
	quarto render --to docx --output $(NAME).docx
$(dest)/$(NAME).odt: $(src)
	quarto render --to odt --output $(NAME).odt

watch:
	ls $(src) | entr make $$TARGET

clean:
	rm -rfv $(dest)/ .quarto/
