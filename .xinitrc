#!/bin/sh

export SCRIPT_DIR="$HOME/Scripts"

while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
do
	sleep 1
done &

sleep 0.2
xrandr --auto
xrandr --output DP-0 --primary --mode 2560x1440 --rate 144
xrandr --output HDMI-0 --mode 1680x1050 --left-of DP-0

# feh -z --no-fehbg --bg-fill $HOME/Pictures/wallpapers/
$SCRIPT_DIR/wallpaper.sh
setxkbmap -layout us -variant altgr-intl

# exec dwm
