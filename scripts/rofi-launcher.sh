#!/bin/bash

# Define the options for the Rofi menu
options="💻 apps\n😀 emojis\n🔌 power\n📡 wifi"

# Use Rofi to display the options
chosen=$(echo -e "$options" | rofi -dmenu -p "Select an option:")

case $chosen in
    "💻 apps")
        rofi -show drun
        ;;
    "😀 emojis")
        rofi -modi emoji -show emoji -kb-custom-1 Ctrl+c
				;;
		"📡 wifi")
				bash /home/zach/scripts/rofi-wifi-menu.sh

        ;;
    *)
        exit 1
        ;;
esac
