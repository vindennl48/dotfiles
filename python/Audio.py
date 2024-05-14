import os
from threading import Thread
from pydub     import AudioSegment
from itertools import groupby
from pathlib   import Path

class Audio:
    @staticmethod
    def get_audio_length(audio_file):
        audio    = AudioSegment.from_file(audio_file)
        duration = audio.duration_seconds
        return duration

    @staticmethod
    def convert_length_to_MinSec(length):
        return f"{int(length // 60)}:{int(length % 60):02}"

    @staticmethod
    def wavToMP3(filepaths):
        threads = []
        
        # Define a worker function for each thread
        def worker(filepath):
            # Load audio file
            try:
                audio = AudioSegment.from_wav(filepath)
            except:
                print(f"Could not load {filepath}")
                return

            # Define output filename and path
            #  output_filename = os.path.splitext(os.path.basename(filepath))[0] + '.mp3'
            #  output_filepath = os.path.join(destination, output_filename)

            output_filepath = filepath.with_suffix(".mp3")

            # Export audio file to MP3 format
            print(f"--> Converting {filepath.stem}...")
            audio.export(output_filepath, format='mp3')
            print(f"    Done converting {filepath.stem}!")

        # Start a worker thread for each input filepath
        for filepath in filepaths:
            t = Thread(target=worker, args=(filepath,))
            threads.append(t)
            t.start()

        # Wait for all threads to finish
        for t in threads:
            t.join()

    @staticmethod
    def MP3toWav(filepaths):
        threads = []
        
        # Define a worker function for each thread
        def worker(filepath):
            # Load audio file
            try:
                audio = AudioSegment.from_mp3(filepath)
            except:
                print(f"Could not load {filepath}")
                return

            # Define output filename and path
            #  output_filename = os.path.splitext(os.path.basename(filepath))[0] + '.mp3'
            #  output_filepath = os.path.join(destination, output_filename)

            output_filepath = filepath.with_suffix(".wav")

            # Export audio file to MP3 format
            print(f"--> Converting {filepath.stem}...")
            audio.export(output_filepath, format='wav')
            print(f"    Done converting {filepath.stem}!")

        # Start a worker thread for each input filepath
        for filepath in filepaths:
            t = Thread(target=worker, args=(filepath,))
            threads.append(t)
            t.start()

        # Wait for all threads to finish
        for t in threads:
            t.join()
