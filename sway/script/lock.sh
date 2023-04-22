#!/bin/bash
screenlockbg="/tmp/screenlockbg.png"
screenlock="grim \-s 1 $screenlockbg && convert $screenlockbg -blur 0x2.5 -shave 3 -bordercolor white -border 3 ~/.local/share/assets/lock_vector_smaller_wshadow.png -gravity center -geometry +4+0 -composite $screenlockbg && swaylock -f -i $screenlockbg -s fill"
swaymsg exec "$screenlock"
