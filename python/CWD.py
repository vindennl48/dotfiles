# used for keeping track of current working directories
# can store multiple and switch between them
# can also store from vim and open in another terminal


import os, sys, argparse, editor
from Files import Files, Settings
from simple_term_menu import TerminalMenu


## Global Variables ############################################################
settingsDir  = Files.newPath("~/.config/CWD/")
settingsPath = settingsDir / "settings.json"
################################################################################


## Helpful Functions ###########################################################
def reIterList(x):
    x.sort()
    for i, item in enumerate(x):
        item[0] = i

def getNextIter(x):
    max = 0
    for item in x:
        if item[0] > max:
            max = item[0]
    return max + 1
################################################################################


## Main Program ################################################################
if __name__ == "__main__":
    settings = Settings(
        settingsPath,
        {
            "paths": []
        }
    )
    reIterList(settings.json["paths"])


    ## Get cmd arguments #######################################################
    parser = argparse.ArgumentParser()
    parser.add_argument( "-a", "--add", help = "Add a directory to the list" )
    parser.add_argument( "-d", "--dump", action = "store_true", help = "Get a list of all directories" )
    args = parser.parse_args()
    ############################################################################


    ## Adding cmd to json ######################################################
    if args.add:
        newPath = Files.newPath(args.add).absolute()
        settings.json["paths"].append([
            getNextIter(settings.json["paths"]),
            str(newPath)
        ])
        settings.save()
        exit()
    ############################################################################


    ## Dumping the saved directories ###########################################
    if args.dump:
        result = "\n".join([ x[1] for x in settings.json["paths"] ]) + "\n"
        sys.stdout.write(result)
        exit()
    ############################################################################


    ## Set current directory ###################################################
    items = ["=> Edit List"] + [ x[1] for x in settings.json["paths"] ]
    mainMenu = TerminalMenu(
        menu_entries         = items,
        title                = f'List of Working Directories',
        menu_cursor          = "> ",
        menu_cursor_style    = ("fg_red", "bold"),
        menu_highlight_style = ("fg_red", "bold"),
        cycle_cursor         = True,
        clear_screen         = True
    )
    menuAnswer = mainMenu.show()

    if menuAnswer == None:
        exit()

    if menuAnswer > 0:
        menuAnswer = Files.newPath(items[menuAnswer]).absolute()
        output = f'cd "{menuAnswer}"'
        sys.stdout.write(output)
    ############################################################################


    ## Change list of directories ##############################################
    elif menuAnswer == 0: # Edit List
        items  = items[1:] # remove custom entries
        result = "\n".join([ x for x in items ])
        result = editor.edit(contents = result)

        if result == None:
            exit()

        result = result.decode()

        if result[-1] == "\n":
            result = result[:-1]
        result = result.split("\n")

        changedList = []
        for i, entry in enumerate(result):
            changedList.append([i, entry])

        settings.json["paths"] = changedList
        settings.save()
    ############################################################################
