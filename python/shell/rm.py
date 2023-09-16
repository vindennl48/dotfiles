

import argparse
from send2trash import send2trash
from Files import Files

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "items",
        nargs = '+',
        help  = "Move items to trash"
    )
    args = parser.parse_args()
    items = [ Files.newPath(x) for x in args.items ]

    for item in items:
        if not item.exists():
            print(f'##> File does not exist!: "{item.absolute()}"')
            continue
        send2trash(item)
        print(f'==> To Recycle Bin: "{item.absolute()}"')
