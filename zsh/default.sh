#!/usr/bin/sh

#underline=`tput smul`
#nounderline=`tput rmul`

main_func () {
    if [ -z $DESKTOP_SESSION ]
    then
        DATE_ICON=" Date    "
        KERNEL_ICON=" Kernel  "
        BATTERY_ICON=" Battery "
    else
        DATE_ICON="  "
        KERNEL_ICON="  "
        BATTERY_ICON="  "

    fi
    printf "$DATE_ICON| $(date)\n"
    printf "$KERNEL_ICON| $(uname -sr)\n"
    echo -e "$BATTERY_ICON| $(acpi -bi | sed 's/Battery 0: //g' | tr '\n' ' ')"
}

main_func
