#!/bin/bash
# dependencies : mpvpaper socat

ARGS1=$1
# PATHTOVID="$HOME/Videos/live-wp/elaina-butterflies-wandering-witch-moewalls-com.mp4"
PATHTOVID="$HOME/Videos/live-wp/sed-edited.mp4"
# PATHTOVID="$HOME/Videos/live-wp/Mumei Terror.mp4"
# PATHTOVID="$HOME/Videos/live-wp/inaaaaa.mp4"

main () {
    case "$ARGS1" in
        "toggle") echo 'cycle pause' | socat - /tmp/mpvsocket
            ;;
        *) launch
            ;;
    esac
    exit
}

launch () {
    if [ -z "$(pidof mpvpaper)" ]
    then
        mpvpaper -o '--loop=inf' eDP-1 "$PATHTOVID"
        exit
    fi
    exit 1
}

main
