#!/usr/bin/env bash

setxkbmap -option "caps:swapescape" &
feh --bg-fill "1_good.jpg" &
"$HOME/.local/bin/autolock.sh" &
nm-applet &
blueman-tray &
"$HOME/Tools/pCloud/pcloud" &
"$HOME/Tools/davmail/davmail" &
#compton --config "$HOME/.config/compton/compton.conf" &
