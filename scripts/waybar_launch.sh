#!/usr/bin/env bash

# Kill ALL Waybar instances (avoid duplicates)
pkill -f "waybar -q"

# Determine the correct output
if hyprctl monitors | grep "HDMI-A-2"; then
	waybar -c ~/.config/waybar/config-HDMI.jsonc &
else
		waybar -c ~/.config/waybar/config-EDP.jsonc &
fi

