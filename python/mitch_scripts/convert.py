from Audio import Audio
from Files import Files

def convert(file_type, files):
    files = [ Files.newPath(x) for x in files ]

    if file_type == "wav":
        Audio.MP3toWav(files)
    elif file_type == "mp3":
        Audio.wavToMP3(files)
    else:
        print("Invalid Arguments")

