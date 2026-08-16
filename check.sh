#!/bin/sh
# Flags any character outside printable ASCII, except the Braille block
# (U+2800-U+28FF) used by the decorative art in index.html.
# No output means clean.
python3 - "$@" <<'PY'
import sys, unicodedata
files = ["index.html", "style.css", "README.md", "_headers", "robots.txt"]
bad = 0
for f in files:
    for n, line in enumerate(open(f, encoding="utf-8"), 1):
        for c in line.rstrip("\n"):
            o = ord(c)
            if o == 9 or 32 <= o <= 126 or 0x2800 <= o <= 0x28FF:
                continue
            print("%s:%d: U+%04X %s" % (f, n, o, unicodedata.name(c, "?")))
            bad = 1
sys.exit(bad)
PY
