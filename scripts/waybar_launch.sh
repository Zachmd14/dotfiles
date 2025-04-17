#!/usr/bin/env bash

# Kill ALL Waybar instances (avoid duplicates)
pkill -f "waybar -q"

# Determine the correct output
if hyprctl monitors | grep "eDP-1"; then
	waybar -c ~/.config/waybar/config-EDP.jsonc &
else
	waybar -c ~/.config/waybar/config-DP-1.jsonc &
fi

