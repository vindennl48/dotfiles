import os, time

# Switch to SoundDesk
os.system("SwitchAudioSource -u SoundDesk_UID")
#  {"name": "SoundDesk Virtual Driver", "type": "output", "id": "114", "uid": "SoundDesk_UID"}

# open MIDI settings
os.system('open "/System/Applications/Utilities/Audio MIDI Setup.app"')
time.sleep(2)
# open Bome Midi
os.system('open "/Users/mitch/Documents/LOF/Bome/SoundDesk.bmtp"')
time.sleep(2)
# open Stems Desk
os.system('open "/Users/mitch/Documents/LOF/SoundDesk/StemRecord_230824.sdsk"')
time.sleep(2)
# open Main Desk
os.system('open "/Users/mitch/Documents/LOF/SoundDesk/Main_230823.sdsk"')
time.sleep(2)
# open studio one
os.system('open "/Applications/Studio One 5.app"')

# open ableton
#  os.system('open "/Applications/Ableton\ Live\ 11\ Standard.app/"')
