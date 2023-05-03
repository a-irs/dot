#!/usr/bin/env python3

from pandocfilters import toJSONFilter, Str, Math
import re
import sys

# converts ASCII arrows to InlineMath arrows or UTF8 characters
rep = {
    "->": {
        "latex": r'\rightarrow',
        "utf8": '→',
    },
    "=>": {
        "latex": r'\Rightarrow',
        "utf8": '⇒',
    },
    "<-": {
        "latex": r'\leftarrow',
        "utf8": '←',
    },
    "<=": {
        "latex": r'\Leftarrow',
        "utf8": '⇐',
    },
    "<->": {
        "latex": r'\leftrightarrow',
        "utf8": '↔',
    },
    "<=>": {
        "latex": r'\Leftrightarrow',
        "utf8": '⇔',
    },
}
rep = dict((re.escape(k), v) for k, v in rep.items())
pattern = re.compile("|".join(rep.keys()))

def replace(key, value, format, meta):

    if format == 'latex':
        if key == 'Str':
            s, count = pattern.subn(lambda m: rep[re.escape(m.group(0))]["latex"], value)
            if count > 0:
                # print(key, value, s, file=sys.stderr)
                return Math(dict(t="InlineMath", c=[]), "$" + s + "$")
            else:
                return Str(s)

    elif format in ['markdown', 'html']:
        if key == 'Str':
            s = pattern.sub(lambda m: rep[re.escape(m.group(0))]["utf8"], value)
            return Str(s)

if __name__ == "__main__":
    toJSONFilter(replace)
