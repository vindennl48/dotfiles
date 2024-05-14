from Audio import Audio
from Files import Files

def error():
    print("Invalid input:")
    print("convert: [wav,mp3] <files to convert>")

def convert(args):
    if len(args) < 2:
        error()
        exit()

    type  = args[0]
    files = [ Files.newPath(x) for x in args[1:] ]

    if type == "wav":
        Audio.MP3toWav(files)
    elif type == "mp3":
        Audio.wavToMP3(files)
    else:
        error()

