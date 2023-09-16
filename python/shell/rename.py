
import argparse, editor, re
from Files import Files


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-f",
        "--files",
        action  = "store_true",
        help    = "Search Folders"
    )
    parser.add_argument(
        "-d",
        "--dirs",
        action = "store_true",
        help   = "Search Directories"
    )
    parser.add_argument(
        "grep",
        nargs = '+',
        help  = "Move items to trash"
    )
    args = parser.parse_args()
    if not args.grep:
        exit()


    ## Compile files from cli ##################################################
    items = [ Files.newPath(x) for x in args.grep ]

    items = [ x for x in items if (args.dirs and x.is_dir()) \
            or (args.files and not x.is_dir()) \
            or (not args.dirs and not args.files) ]
    ############################################################################


    ## Setup vim ###############################################################
    result = editor.edit(
        contents = "\n".join([
            str(x.absolute()) for x in items
        ])
    )

    if not result:
        exit()
    result = result.decode().split("\n")
    result = [
        x for x in result
        if not bool(re.match(r'^\s*#.*', x)) # ignore commented lines
        and x != ''                          # ignore empty lines
    ]
    ############################################################################


    ## Make changes ############################################################
    ############################################################################


    print("result:", result)
