#!/bin/bash
if pgrep -x "waybar" > /dev/null; then
    killall waybar
else
    bash ~/scripts/waybar_launch.sh
fi
