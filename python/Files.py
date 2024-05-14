import os, shutil, json
from pathlib import Path
from send2trash import send2trash

class Files:
    @staticmethod
    def newPath(path):
        path = str(path)
        if path == ".":
            path = Files.getcwd()
        #  elif path == "/":
        #      path = path
        elif len(path) > 1:
            if path[:2] == "~/":
                path = Path.home() / path[2:]
            elif path[:2] == "./":
                path = Files.getcwd() / path[2:]
            elif path[0] != "/":
                path = Files.getcwd() / path
        return Path(path)

    @staticmethod
    def getcwd():
        return Path(os.getcwd())
        #  This only references the path to Files.py after symlink,
        #  not working directory
        #  return Path(os.path.dirname(os.path.realpath(__file__)))

    @staticmethod
    def mkdir(path):
        path = Files.newPath(path)
        if not path.exists():
            path.mkdir(parents=True, exist_ok=True)
        return path

    @staticmethod
    def ls(path, substr=None):
        path = Files.newPath(path)
        if not path.exists():
            return []
        result = [Path(x) for x in path.iterdir()]
        if substr != None:
            result = [ x for x in result if substr in x.name ]
        return result

    @staticmethod
    def lsFiles(path, suffix=None, substr=None, notSubstr=None):
        path = Files.newPath(path)
        if not path.exists():
            return []
        result = [Path(x) for x in path.iterdir() if not x.is_dir()]
        if suffix != None:
            suffix = "." + suffix if suffix[0] != "." else suffix
            result = [ x for x in result if x.suffix.lower() == suffix.lower() ]
        if substr != None:
            result = [ x for x in result if substr in x.name ]
        if notSubstr != None:
            result = [ x for x in result if not notSubstr in x.name ]
        return result

    @staticmethod
    def lsFolders(path, substr=None):
        path = Files.newPath(path)
        if not path.exists():
            if path.is_symlink():
                print("prob: ", path.readlink())
            return []
        result = [Path(x) for x in path.iterdir() if x.is_dir()]
        if substr != None:
            result = [ x for x in result if substr.lower() in x.name.lower() ]
        return result

    @staticmethod
    def rename(path, newName):
        path = Files.newPath(path)
        newPath = path.parent / newName
        path.rename(newPath)
        return newPath

    @staticmethod
    def move(path, newDir):
        path = Files.newPath(path)
        newDir = Path(newDir)
        newPath = newDir / path.name
        path.rename(newPath)
        return newPath

    @staticmethod
    def moveAndRename(path, newPath):
        path = Files.newPath(path)
        newPath = Path(newPath)
        if newPath.exists() or not path.exists():
            return
        path.rename(newPath)

    # TODO: need to return the new paths in a new array
    @staticmethod
    def moveAll(paths, newDir):
        newDir = Path(newDir)
        for path in paths:
            path = Files.newPath(path)
            Files.move(path, newDir)

    @staticmethod
    def copy(path, newDir):
        path = Files.newPath(path)
        newDir = Path(newDir)
        newPath = newDir / path.name
        shutil.copy(path, newPath)
        return newPath

    # TODO: need to return the new paths in a new array
    @staticmethod
    def copyAll(paths, newDir):
        newDir = Path(newDir)
        for path in paths:
            path = Files.newPath(path)
            Files.copy(path, newDir)

    @staticmethod
    def remove(path, confirm=True):
        path = Files.newPath(path)
        if not path.exists():
            return
        if confirm:
            print("==> Are you sure you want to remove:")
            print("   ", path.absolute())
            answer = input("  > (Y)es/(N)o: ")
            if answer.lower() == "y" or answer.lower() == "yes":
                send2trash(path)
            else:
                print("    Nothing was removed")
        else:
            send2trash(path)

    @staticmethod
    def removeAll(paths, confirm=True):
        for path in paths:
            Files.remove(path, confirm)

    @staticmethod
    def createSymLink(fromPath, toPath, isDirectory=True):
        toPath.symlink_to(fromPath, isDirectory)

    @staticmethod
    def wasEditedWithin(path, days=1):
        path = Files.newPath(path)
        xDaysAgo = datetime.now() - timedelta(days=days)
        filetime = datetime.fromtimestamp(os.path.getctime(path))
        return xDaysAgo < filetime

class STD:
    @staticmethod
    def printList(x, leader=""):
        for i in x:
            print(leader, i)

    @staticmethod
    def removeFileExt(path):
        return os.path.splitext(str(path))[0]

class Settings:
    # path = path to settings json INCLUDING the json file name
    def __init__(self, path, default={}) -> None:
        self.file = Files.newPath(path)
        self.json = default

        Files.mkdir(self.file.parent)

        if not self.file.exists():
            with open(self.file, 'w') as f:
                json.dump(self.json, f, indent=2)
        else:
            with open(self.file, 'r') as f:
                self.json = json.load(f)

    def save(self):
        with open(self.file, 'w') as f:
            json.dump(self.json, f, indent=2)

from datetime import datetime, timedelta

if __name__ == "__main__":
    cwd = Files.getcwd()
    zip_file = Files.newPath("Zip.py")

    two_days_ago = datetime.now() - timedelta(days=2)
    filetime = datetime.fromtimestamp(os.path.getctime(zip_file))

    print( "two_days_ago: ", two_days_ago )
    print( "filetime:     ", filetime )

    if two_days_ago < filetime:
        print("this file is newer than 2 days")
    else:
        print("this file is older than 2 days")
