#!/bin/env python3
import hashlib
from secrets import token_hex
from secrets import token_bytes
import argparse

import time
from pathlib import Path


def main():
    timestamp = int(time.time())
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-s",
        "--secret-path",
        type=Path,
        default=Path.cwd().joinpath(f"{timestamp}.secret"),
    )
    parser.add_argument(
        "-k", "--key-path", type=Path, default=Path.cwd().joinpath(f"{timestamp}.key")
    )
    args = parser.parse_args()

    secret_bytes: bytes = token_bytes(512)
    key_bytes: bytes = hashlib.sha3_512(secret_bytes).digest()

    key_path: Path = args.key_path
    secret_path: Path = args.secret_path

    with open(key_path, "w") as fp:
        fp.write(key_bytes.hex())

    with open(secret_path, "w") as fp:
        fp.write(secret_bytes.hex())


if __name__ == "__main__":
    main()
