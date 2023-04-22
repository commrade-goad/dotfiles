#!/bin/bash
cat ~/.config/sway/config | grep bindsym | sed 's/    //g' | sed 's/bindsym/\n/g' | sed 's/--to-code//g' | sed 's/--locked//g' | sed 's/--release//g' | less

