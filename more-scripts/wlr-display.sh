#!/bin/sh

option_resolution () {
    # getting the available resolution
    SETTINGS_RES=$(wlr-randr | grep -e "    " | awk -F' ' '{print$1, "@", $3}')
    USER_VALUE_DISPLAY_SETTINGS=$(echo "$SETTINGS_RES" | rofi -dmenu -window-title " Select Resolution " | sed 's/ //g')
    # checking the user input and execute the command
    if [ -z $USER_VALUE_DISPLAY_SETTINGS ]
    then
        exit 1
    else
        wlr-randr --output $USER_VALUE_DISPLAY --mode $USER_VALUE_DISPLAY_SETTINGS
    fi
}

option_scale () {
    CURRENT_SCALE=$(wlr-randr | grep -e "Scale" | sed 's/Scale: //')
    USER_VALUE_SCALE=$(echo "Current Value : $CURRENT_SCALE" | rofi -dmenu -window-title " Type Scale ")
    # checking the user input and execute the command
    if [ -z "$USER_VALUE_SCALE" ]
    then
        exit 1
    elif [ "$USER_VALUE_SCALE" = "Current Value : $CURRENT_SCALE" ]
    then
        exit 1
    else
        wlr-randr --output $USER_VALUE_DISPLAY --scale $USER_VALUE_SCALE
        exit 1
    fi
}

option_position () {
    CURRENT_POSITION=$(wlr-randr | grep -e "Position" | sed 's/Position: //')
    USER_VALUE_POSITION=$(echo "Current Value : $CURRENT_POSITION" | rofi -dmenu -window-title " Type Position ")
    # checking the user input and execute the command
    if [ -z "$USER_VALUE_POSITION" ]
    then
        exit 1
    elif [ "$USER_VALUE_POSITION" = "Current Value : $CURRENT_POSITION" ]
    then
        exit 1
    else
        echo wlr-randr --output $USER_VALUE_DISPLAY --pos $USER_VALUE_POSITION
        exit 1
    fi
}

# option_transform () {
#     MODES=("normal" "90" "180" "270" "flipped" "flipped-90" "flipped-180" "flipped-270")
#     USER_VALUE_TRANSFORM=$(echo -e "${MODES[@]}" | rofi -sep ' ' -dmenu -window-title " Choose Mode ")
#     if [ -z $USER_VALUE_TRANSFORM ]
#     then
#         exit 1
#     fi
#     if [[ "${MODES[@]}" =~ "${USER_VALUE_TRANSFORM}" ]]
#     then
#         wlr-randr --output $USER_VALUE_DISPLAY --transform $USER_VALUE_TRANSFORM
#     else
#         exit 1
#     fi
# }

main () {
    # check if wlr-randr exist
    cat /usr/bin/wlr-randr >/dev/null 2>&1
    if [ $? != 0 ]
    then
        echo ERROR : wlr-randr is not installed!
        exit 1
    fi

    # getting the available display
    DISPLAY=$(wlr-randr | awk '/^[a-zA-Z-]+-[0-9]+/ {print $1}')
    USER_VALUE_DISPLAY=$(echo $DISPLAY | rofi -dmenu -window-title " Select Display ")
    
    # checking user input
    if [ $? != 0 ]
    then
        exit 1
    fi
    
    # ask what to do
    RESOLUTION="Resolution"
    SCALE="Scale"
    POSITION="Position"
    TRANSFORM="Transform (BROKE)"
    USER_VALUE_TODO=$(echo -e "$RESOLUTION\n$SCALE\n$POSITION\n$TRANSFORM" | rofi -dmenu -window-title " Choose what to do ")
    
    
    # checking the input
    case $USER_VALUE_TODO in
        $RESOLUTION) option_resolution ;;
        $SCALE) option_scale ;;
        $POSITION) option_position;;
        # $TRANSFORM) option_transform;;
        * ) exit 1;;
    esac
}

main
