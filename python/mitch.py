import argparse
from mitch_scripts.convert  import convert
from mitch_scripts.sleep    import sleep
from mitch_scripts.profiles import list_profiles, switch_profiles
from mitch_scripts.safe     import run_safe

def main():
    parser = argparse.ArgumentParser(prog='mitch')
    subparsers = parser.add_subparsers(dest='command')

    # Subparser for the 'convert' command
    parser_convert = subparsers.add_parser('convert', help='Convert files')
    parser_convert.add_argument('--to', required=True, choices=['mp3', 'wav'], help='Type to convert to')
    parser_convert.add_argument('files', nargs='+', help='Files to convert')
    parser_convert.set_defaults(func=lambda args: convert(args.to, args.files))

    # Subparser for the 'sleep' command
    parser_sleep = subparsers.add_parser('sleep', help='Enable or disable sleep mode')
    parser_sleep.add_argument('will_sleep', choices=['on', 'off'], help='Turn sleep mode on or off')
    parser_sleep.set_defaults(func=lambda args: sleep(args.will_sleep))

    # Subparser for the 'profiles' command
    parser_profiles = subparsers.add_parser('profiles', help='Switch profiles')
    parser_profiles.add_argument('type', choices=['nvim', 'zsh'], help='Choose profile type')
    parser_profiles.add_argument('action', choices=['ls', 'list', 'switch'], help='Choose profile action')
    parser_profiles.add_argument('profile', nargs='?', default=None, help='Select the profile you want to switch to')
    parser_profiles.set_defaults(func=lambda args: list_profiles(args.type) if args.action == 'ls' or args.action == 'list' else switch_profiles(args.type, args.profile))

    # Subparser for the 'safe' command
    parser_safe = subparsers.add_parser('safe', help='Encrypt or decrypt files')
    parser_safe.add_argument('--mode', choices=['encrypt', 'decrypt', 'auto'], default='auto', help='Force action type, defaults to "auto"')
    parser_safe.add_argument('--silent', action='store_true', help='Enable silent mode to suppress output')
    parser_safe.add_argument('files', nargs='+', help='Files or folders to convert')
    parser_safe.set_defaults(func=lambda args: run_safe(args.files, args.mode, args.silent))

    args = parser.parse_args()
    if args.command is None:
        parser.print_help()
    else:
        args.func(args)

if __name__ == "__main__":
    main()


# ################################################################################
# 
# # This script enables us to run a collection of scripts easily
# 
# import argparse
# from mitch_scripts.convert  import convert
# from mitch_scripts.sleep    import sleep
# from mitch_scripts.profiles import list_profiles, switch_profiles
# from mitch_scripts.safe     import run_safe
# 
# class SafeAction(argparse.Action):
#     def __call__(self, parser, namespace, values, option_string=None):
#         # Set the safe attribute
#         setattr(namespace, self.dest, values)
#         
#         # Add --decrypt and --encrypt options as flags
#         parser.add_argument('--decrypt', action='store_true', help='decrypt: Only decrypt files')
#         parser.add_argument('--encrypt', action='store_true', help='encrypt: Only encrypt files')
#         parser.add_argument('--silent',  action='store_true', help='silent: Suppress output')
# 
# def parse_arguments():
#     parser = argparse.ArgumentParser()
#     parser.add_argument( "--convert",         nargs="*", help = "convert audio: [wav,mp3] <files to convert>" )
#     parser.add_argument( "--sleep",           nargs=1,   help = "sleep: [on,off]: Enable sleep? on will allow sleep, off will disable sleep." )
#     parser.add_argument( "--list-profiles",   nargs=1,   help = "list: [nvim,zsh]: list available profiles" )
#     parser.add_argument( "--switch-profiles", nargs=2,   help = "switch: [nvim,zsh] <profile name>: switch profiles" )
#     parser.add_argument( "--safe",            nargs="*", help = "safe: [paths to convert]", action=SafeAction )
#     return parser.parse_args()
# 
# if __name__ == "__main__":
#     args = parse_arguments()
# 
#     if args.convert:
#         convert(args.convert)
# 
#     if args.sleep:
#         sleep(args.sleep)
# 
#     if args.list_profiles:
#         list_profiles(args.list_profiles)
# 
#     if args.switch_profiles:
#         switch_profiles(args.switch_profiles)
# 
#     if args.safe:
#         paths = args.safe[0]
#         mode   = None
#         silent = False
# 
#         if getattr(args, 'decrypt', False):
#             mode = 'decrypt'
#         elif getattr(args, 'encrypt', False):
#             mode = 'encrypt'
# 
#         if getattr(args, 'silent', False):
#             silent = True
# 
#         run_safe(paths, mode, silent)
