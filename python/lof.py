import argparse, time, re, os, configparser
from datetime import datetime
from Audio import Audio
from Files import Files
from ConfigEdit import ini_to_dict, dict_to_ini

LOG_FILE_LOCATION          = Files.newPath("/Users/mitch/Desktop/lof_record")
#  LOG_PARENT_UPLOAD_LOCATION = Files.newPath(f"/Users/mitch/Desktop/{datetime.now().strftime('%y%m%d')}")
LOG_PARENT_UPLOAD_LOCATION = Files.newPath(f"/Users/mitch/Library/CloudStorage/GoogleDrive-landoffiresband@gmail.com/My Drive/LOF/Practice Logs/{datetime.now().strftime('%Y%m%d')}")
REAPER_INI_PATH            = Files.newPath("/Users/mitch/Library/Application Support/REAPER/reaper.ini")

def clean_log_folder():
    ans = input("Would you like to clean the log folder?: ").lower()
    if ans == "y" or ans == "yes":
        Files.removeAll(Files.ls(LOG_FILE_LOCATION), confirm=False)
        print("\n--> Log folder cleaned!\n")
    else:
        print("\n--> No worries, nothing deleted!\n")

def create_log_folder_and_upload():
    print("\n--> Converting log files to mp3..")
    # get list of wav files
    wav_files = Files.lsFiles(LOG_FILE_LOCATION, suffix="wav")

    # convert to mp3
    Audio.wavToMP3(wav_files)

    print("\n--> Creating upload folder..")
    Files.mkdir(LOG_PARENT_UPLOAD_LOCATION)
    mp3_files = Files.lsFiles(LOG_FILE_LOCATION, suffix="mp3")
    # print all the mp3 files
    for file in mp3_files:
        print(f"    {file}")

    Files.moveAll(mp3_files, LOG_PARENT_UPLOAD_LOCATION)
    print("\n--> Done!\n")

# for the INI files
def replace_variable(file, variable_name, new_value):
    # Define the regex pattern
    pattern = r'^({})=(.*)$'.format(re.escape(variable_name))
    
    # Split the file string into lines
    lines = file.split('\n')
    
    # Iterate over the lines
    for i, line in enumerate(lines):
        # Check if the line matches the pattern
        match = re.match(pattern, line)
        if match:
            # Replace the value with the new value
            lines[i] = f'{variable_name}={new_value}'
            break
    
    # Join the lines back into a string
    modified_file = '\n'.join(lines)
    
    return modified_file

def disableSleep(willDisable):
    if willDisable:
        os.system("sudo pmset -a disablesleep 1")
        print("\n--> Disabled Sleep!\n")
    else:
        os.system("sudo pmset -a disablesleep 0")
        print("\n--> Enabled Sleep!\n")

def open_midi_translator():
    # start Midi Translator
    os.system('nohup python3 "/Users/mitch/Documents/Code/Python/MidiRoute/main.py" &')

def start_programs(type_of_startup="practice"):
    disableSleep(True)

    # Update reaper.ini with the correct audio device
    new_device = "LOF Practice" if type_of_startup == "practice" else "LOF Show"

    reaper_ini = ini_to_dict(REAPER_INI_PATH)
    reaper_ini["REAPER"]["coreaudioindevnew"]  = new_device
    reaper_ini["REAPER"]["coreaudiooutdevnew"] = new_device
    reaper_ini["REAPER"]["useinnc"]            = 3
    dict_to_ini(REAPER_INI_PATH, reaper_ini)

    # Switch MAC output to different output
    os.system("SwitchAudioSource -u BlackHole2ch_UID")

    # start Midi Translator
    os.system('nohup python3 "/Users/mitch/Documents/Code/Python/MidiRoute/main.py" &')
    time.sleep(2)

    #  open Reaper
    os.system('open "/Applications/REAPER.app"')

    #  # open MIDI settings
    #  time.sleep(5) # make sure it's on top
    #  os.system('open "/System/Applications/Utilities/Audio MIDI Setup.app"')

def reset():
    disableSleep(False)
    os.system("SwitchAudioSource -u BuiltInSpeakerDevice")

    # Switch audio device to mac speakers and unset audio aliases
    new_device = "MacBook Air Speakers"
    reaper_ini = ini_to_dict(REAPER_INI_PATH)
    reaper_ini["REAPER"]["coreaudioindevnew"]  = new_device
    reaper_ini["REAPER"]["coreaudiooutdevnew"] = new_device
    reaper_ini["REAPER"].pop("useinnc")
    dict_to_ini(REAPER_INI_PATH, reaper_ini)

    print("\n--> Reset Desktop Audio Device!\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--live",                  action="store_true", help="Start all programs for live")
    parser.add_argument("--practice",              action="store_true", help="Start all programs for practice")
    parser.add_argument("-m", "--midi-translator", action="store_true", help="Start all programs for practice")
    parser.add_argument("--reset",                 action="store_true", help="Reset sleep and audio device")
    parser.add_argument("--upload",                action="store_true", help="Start all programs for LOF")
    parser.add_argument("--clean",                 action="store_true", help="Clean up log folder")
    parser.add_argument("--disable-sleep",         action="store_true", help="Disable sleep")
    parser.add_argument("--enable-sleep",          action="store_true", help="Enable sleep")
    args = parser.parse_args()

    if args.live:
        start_programs("live")
    if args.practice:
        start_programs("practice")
    if args.midi_translator:
        open_midi_translator()
    if args.upload:
        create_log_folder_and_upload()
        clean_log_folder()
        reset()
    if args.clean:
        clean_log_folder()
    if args.reset:
        reset()
    if args.disable_sleep:
        disableSleep(True)
    if args.enable_sleep:
        disableSleep(False)
