#!/usr/bin/env bash

set -xe

WALLPAPER=$1
SWIENGPATH="$HOME/.local/share/assets/swieng"
COLORSCHEME="$SWIENGPATH/custom-color.toml"

if [[ -z $WALLPAPER ]] then
    exit 1
fi

swieng-colorgen -o "$SWIENGPATH/template/custom-color-ref" "$WALLPAPER"
echo -e "wallpaper_path = \"$WALLPAPER\"" >> "$SWIENGPATH/template/custom-color-ref"
swieng -i "$SWIENGPATH/template/custom-color-gen.toml" -o "$SWIENGPATH/custom-color.toml" -d "$SWIENGPATH/template/custom-color-ref"

swww img "$WALLPAPER" --transition-step 15 --transition-fps 60

$SWIENGPATH/apply-color.sh
pkill waybar
hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/style.css -c ~/.config/hypr/waybar/config.jsonc
dunstctl reload
export ACCENT_COLOR=$(cat $HOME/.local/share/assets/swieng/custom-color.toml | grep 'accent1' | awk -F ' ' '{print $3}' | sed 's/"//g')
killall -10 kitty
