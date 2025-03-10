#!/usr/bin/env sh

set -xe

# DICTFILE=$1
#
# if [ -z $DICTFILE ] then
#     echo "ERROR: need a dict file to gen."
#     exit
# fi

SWIENGPATH="$HOME/.local/share/assets/swieng"
COLORSCHEME="$SWIENGPATH/custom-color.toml"

HYPRLANDCOLORPATH="$HOME/.config/hypr/color.conf"
HYPRLOCKPATH="$HOME/.config/hypr/hyprlock.conf"
ROFIPATH="$HOME/.config/rofi/sel.rasi"
DUNSTPATH="$HOME/.config/dunst/dunstrc"
WAYBARPATH="$HOME/.config/hypr/waybar/style.css"
# KITTYPATH="$HOME/.config/kitty/color.conf"
NVIMPATH="$HOME/.config/nvim/lua/plugconf/custom-color.lua"
TMUXPATH="$HOME/.config/tmux/tmux.conf"
# ALACRITTYPATH="$HOME/.config/alacritty/sel.toml"
FOOTPATH="$HOME/.config/foot/foot.ini"

swieng -i $SWIENGPATH/config/color.conf -o $HYPRLANDCOLORPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/hyprlock.conf -o $HYPRLOCKPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/sel.rasi -o $ROFIPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/dunstrc -o $DUNSTPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/style.txt -o $WAYBARPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/nvim-color.lua -o $NVIMPATH -d $COLORSCHEME
# swieng -i $SWIENGPATH/config/alacritty-theme.toml -o $ALACRITTYPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/foot.ini -o $FOOTPATH -d $COLORSCHEME
# swieng -i $SWIENGPATH/config/kittycolor.conf -o $KITTYPATH -d $COLORSCHEME
swieng -i $SWIENGPATH/config/tmux.conf -o $TMUXPATH -d $COLORSCHEME
