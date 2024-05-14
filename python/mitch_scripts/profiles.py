import os
from Files import Files, STD

def list_error():
    print("Invalid input:")
    print("list: [nvim,zsh]: list available profiles")

def switch_error():
    print("Invalid input:")
    print("switch: [nvim,zsh] <profile name>: switch profiles")

def list_profiles(args):
    if len(args) < 1:
        list_error()
        exit()

    typ = args[0]
    filepath = ""

    if typ == "nvim":
        filepath = "~/.config/nvim_profiles"
    elif typ == "zsh":
        filepath = "~/.config/zsh_profiles"
    else:
        list_error()

    profiles = Files.lsFolders(filepath)
    STD.printList([ x.name for x in profiles ], "-> ")

def switch_profiles(args):
    if len(args) < 2:
        switch_error()
        exit()

    typ = args[0]
    name = args[1]

    if typ not in ["nvim", "zsh"]:
        switch_error()

    config_filepath = f"~/.config/{typ}_profiles"
    local_filepath = f"~/.local/share/{typ}_profiles"

    profiles = [ x.name for x in Files.lsFolders(config_filepath) ]
    if name not in profiles:
        print(f"Profile '{name}' not found")
        exit()

    os.system(f"rm ~/.config/{typ}; ln -s {config_filepath}/{name} ~/.config/{typ}")
    os.system(f"mkdir -p {local_filepath}/{name}")
    os.system(f"rm ~/.local/share/{type}; ln -s {local_filepath}/{name} ~/.local/share/{type}")
    print(f"Switched to {name}")
