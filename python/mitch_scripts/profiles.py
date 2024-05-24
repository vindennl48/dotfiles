import os
from Files import Files, STD

available_types = ["nvim", "zsh"]

def list_error():
    print("Invalid input:")
    print("list: [nvim,zsh]: list available profiles")

def switch_error():
    print("Invalid input:")
    print("switch: [nvim,zsh] <profile name>: switch profiles")

def list_profiles(prog_type):
    filepath = ""

    if prog_type not in available_types:
        list_error()

    filepath = f"~/.config/{prog_type}_profiles"

    profiles = Files.lsFolders(filepath)
    STD.printList([ x.name for x in profiles ], "-> ")

def switch_profiles(prog_type, profile):
    if prog_type not in available_types:
        switch_error()

    config_filepath = f"~/.config/{prog_type}_profiles"
    local_filepath = f"~/.local/share/{prog_type}_profiles"

    profiles = [ x.name for x in Files.lsFolders(config_filepath) ]
    if profile not in profiles:
        print(f"Profile '{profile}' not found")
        exit()

    os.system(f"rm ~/.config/{prog_type}; ln -s {config_filepath}/{profile} ~/.config/{prog_type}")
    os.system(f"mkdir -p {local_filepath}/{profile}")
    os.system(f"rm ~/.local/share/{type}; ln -s {local_filepath}/{profile} ~/.local/share/{type}")
    print(f"Switched to {profile}")
