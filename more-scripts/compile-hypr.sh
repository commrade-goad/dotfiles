#!/bin/bash

ARG1=$1
ARG2=$2
# PATH
HYPRLAND_PATH="~/git/Hyprland"
XDPH_PATH="~/git/xdg-desktop-portal-hyprland/" # not must for this one can use the arch packages of xdg-desktop-portal-hyprland

# REBUILD HYPRLAND
hyprland_build () {
    echo -e "SC : Moving to $HYPRLAND_PATH to build Hyprland"
    cd $HYPRLAND_PATH
    STATUS=$(stat build/Hyprland | grep Modify | awk -F ' ' '{print$2}')
    echo -e "SC : last build at $STATUS"
    echo -e "SC : Checking for update..."
    git pull
    echo -e "SC : Building Hyprland..."
    sudo make install
}

generate_desktop () {
    sudo cp $HYPRLAND_PATH/example/hyprland.desktop /usr/share/wayland-sessions/
}

# REBUILD XDPH
xdph_build () {
    echo -e "SC : Moving to $XDPH_PATH to build XDG-DESKTOP-PORTAL-Hyprland"
    cd $XDPH_PATH
    echo -e "SC : Checking for update..."
    git pull
    echo -e "SC : Building XDG-DESKTOP-PORTAL-Hyprland..."
    meson build --prefix=/usr
    ninja -C build
    cd hyprland-share-picker && time make all && cd ..
    echo -e "SC : Installing XDG-DESKTOP-PORTAL-Hyprland..."
    ninja -C build install
    sudo cp ./hyprland-share-picker/build/hyprland-share-picker /usr/bin
}

print_help () {
    echo -e "USAGE:"
    echo -e "     ./recompile-hypr.sh build all"
    echo -e "     ./recompile-hypr.sh build xdph"
    echo -e "     ./recompile-hypr.sh build hyprland"
    echo -e "     ./recompile-hypr.sh generate-desktop"
    exit 1
}

main () {
    if [ "$ARG1" == "build" ]
    then
        case $ARG2 in
            "all") hyprland_build && xdph_build ;;
            "hyprland") hyprland_build ;;
            "xdph") xdph_build ;;
            *) echo -e "ERROR : Unknown Second Argument $ARG2" && print_help ;;
        esac
    elif [ "$ARG1" == "generate-desktop" ]
    then
        generate_desktop
        exit 0
    else
        echo -e "ERROR : Unknown Argument $ARG1"
        print_help
    fi
}

# Call main func
main
