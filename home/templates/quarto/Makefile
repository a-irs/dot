# Makefile

NAME = TODO

MAKEFLAGS += -j $(shell nproc)

dest := .output

all: pdf html md docx odt

pdf: $(dest)/$(NAME).pdf
html: $(dest)/$(NAME).html
md: $(dest)/$(NAME).md
docx: $(dest)/$(NAME).docx
odt: $(dest)/$(NAME).odt

src := content/* _extensions/*/* assets/* _quarto.yml Makefile

$(dest)/$(NAME).pdf: $(src)
	quarto render --to pdf && mv -f $(dest)/content/_index.pdf $@
$(dest)/$(NAME).html: $(src)
	quarto render --to html && mv -f $(dest)/content/_index.html $@
$(dest)/$(NAME).md: $(src)
	quarto render --to commonmark_x && mv -f $(dest)/content/_index.commonmark_x.md $@
$(dest)/$(NAME).docx: $(src)
	quarto render --to docx && mv -f $(dest)/content/_index.docx $@
$(dest)/$(NAME).odt: $(src)
	quarto render --to odt && mv -f $(dest)/content/_index.odt $@

watch:
	ls $(src) | entr make $$TARGET

clean:
	rm -rfv $(dest)/ .quarto/
