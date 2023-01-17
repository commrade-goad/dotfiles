#!/bin/bash

COMMAND=$(echo "shutdown|reboot|sleep|logout|lock|1080p|720p" | rofi -sep '|' -dmenu -window-title "  Master ")

if [ -z $COMMAND ] ;  then
	exit
fi

if [ $COMMAND == "shutdown" ] ; then
	systemctl poweroff
elif [ $COMMAND == "reboot" ] ; then
	systemctl reboot
elif [ $COMMAND == "sleep" ] ; then
	screenlockbg="/tmp/screenlockbg.png"
	screenlock="grim \-s 0.1 $screenlockbg && swaylock \-f \-i $screenlockbg \-s fill"
	swaymsg exec $screenlock & systemctl suspend
elif [ $COMMAND == "logout" ] ; then
	swaymsg exit
elif [ $COMMAND == "lock" ] ; then
	screenlockbg="/tmp/screenlockbg.png"
	screenlock="grim \-s 0.1 $screenlockbg && swaylock \-f \-i $screenlockbg \-s fill"
	echo $screenlock
	echo $screenlockbg
	swaymsg exec $screenlock
elif [ $COMMAND == "1080p" ] ; then
	swaymsg output eDP-1 resolution 1920x1080
elif [ $COMMAND == "720p" ] ; then
	swaymsg output eDP-1 resolution 1280x720
else
	exit
fi
