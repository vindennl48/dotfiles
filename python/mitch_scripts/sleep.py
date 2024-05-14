import os

def error():
    print("Invalid input:")
    print("sleep: [on,off]: Enable sleep? on will allow sleep, off will disable sleep.")

def sleep(args):
    if len(args) > 0:
        will_sleep = args[0]
    else:
        error()
        exit()

    if will_sleep == "on":
        os.system("sudo pmset -a disablesleep 0")
        print("Sleep enabled")
    elif will_sleep == "off":
        os.system("sudo pmset -a disablesleep 1")
        print("Sleep disabled")
    else:
        error()
