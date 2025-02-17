#!/usr/bin/env sh

set -xe

SWIENGPATH="$HOME/.local/share/assets/swieng"
COLORSCHEME="$SWIENGPATH/rose-pine-colorscheme.toml"
HYPRLANDCOLORPATH="$HOME/.config/hypr/color.conf"
HYPRLOCKPATH="$HOME/.config/hypr/hyprlock.conf"
ROFIPATH="$HOME/.config/rofi/sel.rasi"
DUNSTPATH="$HOME/.config/dunst/dunstrc"
WAYBARPATH="$HOME/.config/hypr/waybar/style.css"
KITTYPATH="$HOME/.config/kitty/color.conf"
NVIMPATH="$HOME/.config/nvim/lua/custom-color.lua"
# ALACRITTYPATH="$HOME/.config/alacritty/sel.toml"
# FOOTPATH="$HOME/.config/foot/foot.ini"

swieng -i $SWIENGPATH/color.conf -o $HYPRLANDCOLORPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/hyprlock.conf -o $HYPRLOCKPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/sel.rasi -o $ROFIPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/dunstrc -o $DUNSTPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/style.txt -o $WAYBARPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/nvim-color.lua -o $NVIMPATH -d $COLORSCHEME
# swieng -i $SWIENGPATH/alacritty-theme.toml -o $ALACRITTYPATH -d $COLORSCHEME
# swieng -i $SWIENGPATH/foot.ini -o $FOOTPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/kittycolor.conf -o $KITTYPATH -d $COLORSCHEME
