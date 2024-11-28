#!/bin/bash
# dependencies : mpvpaper socat

ARGS1=$1
# PATHTOVID="$HOME/Videos/live-wp/elaina-butterflies-wandering-witch-moewalls-com.mp4"
# PATHTOVID="$HOME/Videos/live-wp/sed-edited.mp4"
# PATHTOVID="$HOME/Videos/live-wp/Mumei Terror.mp4"
# PATHTOVID="$HOME/Videos/live-wp/inaaaaa.mp4"
PATHTOVID="$HOME/Videos/live-wp/shiki-ryougi-saber-fate-grand-order-moewalls-com.mp4"
PATHTOVID="$HOME/Videos/live-wp/Ushio Noa.mp4"

main () {
    case "$ARGS1" in
        "toggle") echo 'cycle pause' | socat - /tmp/mpv-socket
            ;;
        *) launch
            ;;
    esac
    exit
}

launch () {
    if [ -z "$(pidof mpvpaper)" ]
    then
        swww kill
        hyprctl dispatch exec "$HOME/git/mpvpaper/build/mpvpaper -o '--input-ipc-server=/tmp/mpv-socket --loop=inf --no-config --profile=fast --hwdec=vaapi --vo=gpu' eDP-1 \"$PATHTOVID\""
        exit
    else
        kill -9 $(pidof mpvpaper)
        hyprctl dispatch exec swww-daemon
    fi
    exit 1
}

main
