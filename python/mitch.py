# This script enables us to run a collection of scripts easily

import argparse
from mitch_scripts.convert  import convert
from mitch_scripts.sleep    import sleep
from mitch_scripts.profiles import list_profiles, switch_profiles

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument( "--convert",         nargs="*", help = "convert audio: [wav,mp3] <files to convert>" )
    parser.add_argument( "--sleep",           nargs=1,   help = "sleep: [on,off]: Enable sleep? on will allow sleep, off will disable sleep." )
    parser.add_argument( "--list-profiles",   nargs=1,   help = "list: [nvim,zsh]: list available profiles" )
    parser.add_argument( "--switch-profiles", nargs=2,   help = "switch: [nvim,zsh] <profile name>: switch profiles" )
    return parser.parse_args()

if __name__ == "__main__":
    args = parse_arguments()

    if args.convert:
        convert(args.convert)

    if args.sleep:
        sleep(args.sleep)

    if args.list_profiles:
        list_profiles(args.list_profiles)

    if args.switch_profiles:
        switch_profiles(args.switch_profiles)
