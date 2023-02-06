#!/bin/env python3

import re
import sys

with open(sys.argv[1], "r") as srcfile:
    src_text = srcfile.read()


# get rid of c -style /**/ comments

src_text = re.sub(r"/\*.*\*/", "", src_text, flags=re.MULTILINE)


# strip whitespace and single line comments
src_lines = [
    re.sub(r"\s+", "", line)
    for line in src_text.split("\n")
    if not re.match(r"\s*[(//)|#]", line)
]

# get lines with 2 or more non-whitespace characters
valid_lines = [line for line in src_lines if len(line) > 2]

print(len(valid_lines))
