#!/bin/bash

json=$(dunstctl history)
pop_notif=0
appname_summary_pairs=()
while read -r line; do
    appname="$(echo "$line" | jq -r '.appname.data')"
    summary="$(echo "$line" | jq -r '.summary.data')"
    notif_id="$(echo "$line" | jq -r '.id.data')"
    appname_summary_pairs+=("$appname - $summary [$notif_id]")
done <<< "$(echo "$json" | jq -c '.data[][]')"

user_input=$(printf '%s\n' "${appname_summary_pairs[@]}" | rofi -dmenu -window-title "  History ")
pop_notif=$(echo $user_input | awk -F'[' '{print$NF}' | sed 's/\]//g')

if [ $pop_notif > 0 ]
then
    dunstctl history-pop $pop_notif
else
    exit
fi
