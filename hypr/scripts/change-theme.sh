#!/bin/bash

change_waybar() {
    if [ $selected_theme == "cat" ]
    then
        cp ~/.config/hypr/waybar/alternative/style-cat.css ~/.config/hypr/waybar/alternative/style.css
    elif [ $selected_theme == "gruvbox" ]
    then
        cp ~/.config/hypr/waybar/alternative/style-gruvbox.css ~/.config/hypr/waybar/alternative/style.css
    fi
    pkill waybar && hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/alternative/style.css -c ~/.config/hypr/waybar/alternative/config.jsonc
}

change_rofi() {
    sed -i 's/@theme .*/@theme "'"$selected_theme"'"/' $HOME/.config/rofi/config.rasi
}

change_dunst() {
    if [ $selected_theme == "cat" ]
    then
        cp ~/.config/dunst/dunstrc.cat ~/.config/dunst/dunstrc
    elif [ $selected_theme == "gruvbox" ]
    then
        cp ~/.config/dunst/dunstrc.gruvbox ~/.config/dunst/dunstrc
    fi
    pkill dunst
}

change_alacritty() {
    if [ $selected_theme == "cat" ]
    then
        cp ~/.config/alacritty/catppuccin-mocha.yml ~/.config/alacritty/active.yml
    elif [ $selected_theme == "gruvbox" ]
    then
        cp ~/.config/alacritty/gruvbox-material.yml ~/.config/alacritty/active.yml
    fi
}

change_hypr() {
    if [ $selected_theme == "cat" ]
    then
        cp ~/.config/hypr/color-cat.conf ~/.config/hypr/color.conf
    elif [ $selected_theme == "gruvbox" ]
    then
        cp ~/.config/hypr/color-gruvbox.conf ~/.config/hypr/color.conf
    fi
    hyprctl reload
}

change_hyprpaper() {
    if [ $selected_theme == "cat" ]
    then
        hyprctl hyprpaper wallpaper "eDP-1,~/Pictures/Random/kosh6.png" 
        sed -i 's/^wallpaper =.*/wallpaper = eDP-1, \/home\/fernando\/Pictures\/Random\/kosh6.png/' $HOME/.config/hypr/hyprpaper.conf
    elif [ $selected_theme == "gruvbox" ]
    then
        hyprctl hyprpaper wallpaper "eDP-1,~/Pictures/Random/Wallpaper/Motion/Amadeus Normal.jpg" 
        sed -i 's/^wallpaper =.*/wallpaper = eDP-1, \/home\/fernando\/Pictures\/Random\/Wallpaper\/Motion\/Amadeus Normal.jpg/' $HOME/.config/hypr/hyprpaper.conf
    fi
}

change_nvim() {
    if [ $selected_theme == "cat" ]
    then
        sed -i 's/theme =.*/theme = "catppuccin",/' $HOME/.config/nvim/init.lua
        sed -i "s/colorscheme .*/colorscheme catppuccin-mocha')/" $HOME/.config/nvim/lua/opts.lua
        sed -i "s/dashboard.section.header.val =.*/dashboard.section.header.val = kosh/" $HOME/.config/nvim/lua/welcome.lua
    elif [ $selected_theme == "gruvbox" ]
    then
        sed -i 's/theme =.*/theme = "gruvbox-material",/' $HOME/.config/nvim/init.lua
        sed -i "s/colorscheme .*/colorscheme gruvbox-material')/" $HOME/.config/nvim/lua/opts.lua
        sed -i "s/dashboard.section.header.val =.*/dashboard.section.header.val = amadeus/" $HOME/.config/nvim/lua/welcome.lua
    fi
}

change_qt5ct() {
    if [ $selected_theme == "cat" ]
    then
        sed -i 's/color_scheme_path=.*/color_scheme_path=\/home\/fernando\/.config\/qt5ct\/colors\/catppuccin-mocha-green.conf/' $HOME/.config/qt5ct/qt5ct.conf
    elif [ $selected_theme == "gruvbox" ]
    then
        sed -i 's/color_scheme_path=.*/color_scheme_path=\/home\/fernando\/.config\/qt5ct\/colors\/gruvbox.conf/' $HOME/.config/qt5ct/qt5ct.conf
    fi
}

change_qt6ct() {
    if [ $selected_theme == "cat" ]
    then
        sed -i 's/color_scheme_path=.*/color_scheme_path=\/home\/fernando\/.config\/qt6ct\/colors\/catppuccin-mocha-green.conf/' $HOME/.config/qt6ct/qt6ct.conf
    elif [ $selected_theme == "gruvbox" ]
    then
        sed -i 's/color_scheme_path=.*/color_scheme_path=\/home\/fernando\/.config\/qt6ct\/colors\/gruvbox.conf/' $HOME/.config/qt6ct/qt6ct.conf
    fi
}

change_gtk() {
    # GTK3 n GTK+
    if [ $selected_theme == "cat" ]
    then
        sed -i 's/gtk-theme=.*/gtk-theme=Catppuccin-Mocha-Standard-Green-Dark/' $HOME/.local/share/nwg-look/gsettings
        sed -i 's/gtk-theme-name=.*/gtk-theme-name=Catppuccin-Mocha-Standard-Green-Dark/' $HOME/.config/gtk-3.0/settings.ini
        sed -i 's/gtk-theme-name=.*/gtk-theme-name=\"Catppuccin-Mocha-Standard-Green-Dark\"/' $HOME/.gtkrc-2.0
    elif [ $selected_theme == "gruvbox" ]
    then
        sed -i 's/gtk-theme=.*/gtk-theme=Gruvbox-Material-Dark/' $HOME/.local/share/nwg-look/gsettings
        sed -i 's/gtk-theme-name=.*/gtk-theme-name=Gruvbox-Material-Dark/' $HOME/.config/gtk-3.0/settings.ini
        sed -i 's/gtk-theme-name=.*/gtk-theme-name=\"Gruvbox-Material-Dark\"/' $HOME/.gtkrc-2.0
    fi
    nwg-look -a

    # GTK4
    file_to_del=$(find /home/fernando/.config/gtk-4.0/ -maxdepth 1 -type l | tr "\n" " ")
    rm -rf $file_to_del
    if [ $selected_theme == "cat" ]
    then
        cp -r /home/fernando/.config/gtk-4.0/cat/* /home/fernando/.config/gtk-4.0/
    elif [ $selected_theme == "gruvbox" ]
    then
        cp -r /home/fernando/.config/gtk-4.0/gruvbox/* /home/fernando/.config/gtk-4.0/
    fi
}

change_brave_tab(){
    if [ $selected_theme == "cat" ]
    then
        cp $HOME/Desktop/tsoding/simple-new-tab/cat.png $HOME/Desktop/tsoding/simple-new-tab/bg.png
    elif [ $selected_theme == "gruvbox" ]
    then
        cp $HOME/Desktop/tsoding/simple-new-tab/gruvbox.png $HOME/Desktop/tsoding/simple-new-tab/bg.png
    fi
}

main() {
    gruvbox="Gruvbox / Amadeus"
    catppuccin="Catppuccin / Kosh"
    user_choice=$(echo -e "$catppuccin\n$gruvbox" | rofi -dmenu -window-title " Colorscheme ")
    case $user_choice in
        $gruvbox) selected_theme="gruvbox" ;;
        $catppuccin) selected_theme="cat" ;;
        *) exit 1 ;;
    esac
    change_rofi
    change_waybar
    change_dunst
    change_alacritty
    change_hypr
    change_nvim
    change_hyprpaper
    change_qt5ct
    change_qt6ct
    change_gtk
    change_brave_tab
}

main
