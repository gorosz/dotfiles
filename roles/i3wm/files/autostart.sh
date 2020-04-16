#!/usr/bin/env bash

setxkbmap -option "caps:swapescape" &
feh --bg-fill "/usr/share/wallpapers/F31_phare-du-petit-minou/contents/images/2048x1536.jpg" &
"$HOME/.local/bin/autolock.sh" &
nm-applet &
blueman-tray &
"$HOME/Tools/pCloud/pcloud" &
"$HOME/Tools/davmail/davmail" &
#compton --config "$HOME/.config/compton/compton.conf" &
