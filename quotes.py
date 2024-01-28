#!/usr/bin/env python3

import subprocess
import re
import json
from pathlib import Path
import datetime as dt
import xml.etree.ElementTree as ET
from html import unescape
from typing import TypeVar
from textwrap import wrap
from shutil import get_terminal_size


QUOTE_STORE = Path.home().joinpath(".local/quote.json")
FLAG = Path.home().joinpath(".local/.quote.flag")

Path().home().joinpath(".local").mkdir(parents=True, exist_ok=True)

T = TypeVar("T")


def some(x: T | None) -> T:
    if x is not None:
        return x
    raise ValueError("None value")


def get_rss():
    output = subprocess.run(
        r"curl -L https://onethingwell.dev/bits.rss",
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    output.check_returncode()
    return output.stdout.decode("utf-8")


def fetch_quote():
    tree = ET.fromstring(get_rss())
    latest = next(tree.iter("item"))

    content_tag = some(latest.find("description"))
    content = unescape(some(content_tag.text))

    content_paragraphs = [
        str(m.group(1)) for m in re.finditer(r"<p>(.*?)</p>", content)
    ][:-1]

    quote_params = dict(
        text="\n".join(content_paragraphs[:-1]), attrib=content_paragraphs[-1]
    )


    with open(FLAG, "w") as fp:
        fp.write(int(dt.datetime.now().timestamp()).__str__())

    with open(QUOTE_STORE, "w") as fp:
        json.dump(quote_params, fp)

    return quote_params


def main():
    now = dt.datetime.now()

    try:
        with open(FLAG, "r") as fp:
            ts = dt.datetime.fromtimestamp(int(fp.read().strip()))

    except FileNotFoundError:
        ts = dt.datetime.min

    if now.toordinal() > ts.toordinal() or not QUOTE_STORE.exists():
        quote = fetch_quote()

    else:
        with open(QUOTE_STORE, "r") as fp:
            quote: dict[str, str] = json.load(fp)

    (term_width, _) = get_terminal_size()

    quote_fmt = "\n".join(wrap(quote["text"], width=term_width - 8))
    print(quote_fmt)
    print(quote["attrib"])


if __name__ == "__main__":

    main()
