Debugging
=========

To debug filters, run with `pandoc` e.g. like this (or `--lua-filter`):

```bash
$ pandoc --filter=_extensions/filter.py main.md

# which is equivalent to the following (so you can put `jq` in between for example for debugging)
$ pandoc -t json main.md | _extensions/filter.py | pandoc -f json
```


Extensions
===========

Sketchy HTML
------------

<https://github.com/schochastics/quarto-sketchy-html>

Available: [strike through]{.strike}, [cross-off]{.cross}, [highlight]{.highlight}, and [circle]{.circle} text

```bash
quarto add schochastics/quarto-sketchy-html
quarto render --to sketchy-html
```

Include code
------------

<https://github.com/quarto-ext/include-code-files>

```bash
quarto add quarto-ext/include-code-files
```
