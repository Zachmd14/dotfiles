#!/usr/bin/env bash

# Kill ALL Waybar instances (avoid duplicates)
pkill -f "^waybar"

# Get monitor info from hyprctl
monitor_output=$(hyprctl monitors)

# Check specifically for DP-1 (not just containing DP-1)
if echo "$monitor_output" | grep -wq "DP-1"; then
    waybar -c ~/.config/waybar/config-DP-1.jsonc &
else
    waybar -c ~/.config/waybar/config-EDP.jsonc &
fi
