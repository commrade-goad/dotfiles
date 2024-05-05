#!/usr/bin/env bash

kill_mpvpaper () {
    pkill mpvpaper
    rm /tmp/mpvpaper
    rm /tmp/mpvsocket
}

kill_hyprpaper () {
    pkill hyprpaper
}

launch_mpvpaper () {
    if [ "$DESKTOP_SESSION" == "sway" ]
    then
        swaymsg exec ~/.config/sway/script/livewp.sh
    else
        hyprctl dispatch exec ~/.config/sway/script/livewp.sh
    fi
}

launch_hyprpaper () {
    if [ "$DESKTOP_SESSION" == "sway" ]
    then
        swaymsg exec hyprpaper
    else
        hyprctl dispatch exec hyprpaper
    fi
}

MPVPAPERSTAUS=$(pidof mpvpaper)

if [ -z $MPVPAPERSTAUS ]
then
    kill_hyprpaper
    launch_mpvpaper
else
    kill_mpvpaper
    launch_hyprpaper
fi
