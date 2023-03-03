#!/bin/bash

screenlockbg="/tmp/screenlockbg.png"
screenlock="grim \-s 1 $screenlockbg && convert $screenlockbg -blur 0x2.5 -shave 3 -bordercolor white -border 3 ~/.local/share/assets/lock_vector_smaller_wshadow.png -gravity center -geometry +4+0 -composite $screenlockbg && swaylock -f -i $screenlockbg -s fill"

COMMAND=$(echo "shutdown|reboot|sleep|logout|lock|1080p|720p" | rofi -sep '|' -dmenu -window-title "  Master ")

if [ -z $COMMAND ] ;  then
	exit
fi

if [ $COMMAND == "shutdown" ] ; then
	systemctl poweroff
elif [ $COMMAND == "reboot" ] ; then
	systemctl reboot
elif [ $COMMAND == "sleep" ] ; then	
	swaymsg exec "$screenlock" && systemctl suspend
elif [ $COMMAND == "logout" ] ; then
	swaymsg exit
elif [ $COMMAND == "lock" ] ; then
	swaymsg exec "$screenlock"
elif [ $COMMAND == "1080p" ] ; then
	swaymsg output eDP-1 resolution 1920x1080
elif [ $COMMAND == "720p" ] ; then
	swaymsg output eDP-1 resolution 1280x720
else
	exit
fi
