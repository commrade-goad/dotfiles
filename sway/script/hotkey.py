#!/bin/python3
import sys
import fileinput
import subprocess

global path_to_status
path_to_status= "/home/fernando/.local/share/python-hotkey.ini"

def read_args():
    args = sys.argv
    args_len = len(args)
    if args_len < 3 :
        exit(1)
    return args

def read_value(path_to_file):
    value = []
    for line in enumerate(fileinput.input(path_to_file, encoding="utf-8")):
        value.append(line[1].replace("\n", ""))
    return value

def swap_value(path_to_file:str, value_to_swap:str, swap_to:str):
    for i, line in enumerate(fileinput.input(path_to_file, inplace=True)):
        sys.stdout.write(line.replace(value_to_swap, swap_to))
        #if i == 4:sys.stdout.write('\n')  # write a blank line after the 5th line
    return 0

def spawn_notif(type_of:str, toggle_mode:str):
    current_value = int(0)
    text_value = "Failed to get the string!"
    if type_of == "volume":
        if toggle_mode == "up":
            current_value = subprocess.check_output(["/usr/bin/pamixer", "--get-volume"]).decode("utf-8").replace("\n", "")
            text_value:str = f"[ 🔊 ] {current_value}%"
        elif toggle_mode == "down":
            current_value = subprocess.check_output(["/usr/bin/pamixer", "--get-volume"]).decode("utf-8").replace("\n", "")
            text_value:str = f"[ 🔉 ] {current_value}%"
        elif toggle_mode == "enable":
            current_value = subprocess.check_output(["/usr/bin/pamixer", "--get-volume"]).decode("utf-8").replace("\n", "")
            text_value = f"[ 🔊 ] Unmuted ({current_value}%)"
        elif toggle_mode == "disable":
            text_value = "[ 🔇 ] Muted"
        else:
            exit(1)

    if type_of == "touchpad":
        if toggle_mode == "enable":
            text_value = "[  ] Enabled"
        elif toggle_mode == "disable":
            text_value = "[  ] Disabled"
        else:
            exit(1)

    if type_of == "brightness":
        if toggle_mode == "down":
            current_value = subprocess.check_output(["/usr/bin/brightnessctl", "get"]).decode("utf-8").replace("\n", "")
            current_value = round(float(int(current_value)*100/255))
            text_value = f"[ ☾ ] {current_value}%"

        elif toggle_mode == "up":
            current_value = subprocess.check_output(["/usr/bin/brightnessctl", "get"]).decode("utf-8").replace("\n", "")
            current_value = round(float(int(current_value)*100/255))
            text_value = f"[ ☼ ] {current_value}%"
        else:
            exit(1)
    current_value = round(float(current_value))
    progress_bar = f"int:value:{current_value}"
    if type_of != "touchpad":
        subprocess.run(["/usr/bin/dunstify", "--appname=sway", "-h", progress_bar, text_value, "-t", "500"])
    else:
        subprocess.run(["/usr/bin/dunstify", "--appname=sway", text_value, "-t", "500"])

def command(type_of, toggle_mode):
    if type_of == "volume":
        if toggle_mode == "up":
            subprocess.run(["/usr/bin/pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"])
        elif toggle_mode == "down":
            subprocess.run(["/usr/bin/pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"])
        elif toggle_mode == "enable":
            subprocess.run(["/usr/bin/pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"])
        elif toggle_mode == "disable":
            subprocess.run(["/usr/bin/pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"])
        else:
            exit(1)

    if type_of == "touchpad":
        subprocess.run(["/usr/bin/swaymsg", "input", "type:touchpad", "events", "toggle", "enabled", "disabled"])

    if type_of == "brightness":
        if toggle_mode == "down":
            subprocess.run(["/usr/bin/brightnessctl", "set", "5%-"])
        elif toggle_mode == "up":
            subprocess.run(["/usr/bin/brightnessctl", "set", "5%+"])
        else:
            exit(1)

def main():
    use_mode = ""
    get_args = read_args()
    if get_args[2] == "up":
        use_mode = "up"
    elif get_args[2] == "down":
        use_mode = "down"
    elif get_args[2] == "toggle":
        status = read_value(path_to_status)
        if get_args[1] == "volume":
            if "audio = off" in status:
                use_mode="enable"
                swap_value(path_to_status, "audio = off", "audio = on")
            elif "audio = on" in status:
                use_mode="disable"
                swap_value(path_to_status, "audio = on", "audio = off")
            else:
                exit(1)
        elif get_args[1] == "touchpad":
            if "touchpad = on" in status:
                use_mode="disable"
                swap_value(path_to_status, "touchpad = on", "touchpad = off")
            elif "touchpad = off" in status:
                use_mode="enable"
                swap_value(path_to_status, "touchpad = off", "touchpad = on")
            else:
                exit(1)
    else:
        exit(1)
    
    command(get_args[1], use_mode)
    spawn_notif(get_args[1], use_mode)

main()
