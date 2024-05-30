#!/bin/env bash

LAUNCHED=$(pidof hypridle)

if [[ -z $LAUNCHED ]]
then
    hyprctl dispatch exec hypridle
    notify-send "Disabled idle inhibit" -t 2500 -a "System"
else
    pkill hypridle
    notify-send "Enabled idle inhibit" -t 2500 -a "System"
fi
