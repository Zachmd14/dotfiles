#!/bin/bash

# Time in seconds before hiding the cursor (5 seconds in your case)
IDLE_TIME=5

# Get the initial cursor position
last_x=$(xdotool getmouselocation | awk -F '[: ]' '{print $2}')
last_y=$(xdotool getmouselocation | awk -F '[: ]' '{print $4}')

while true; do
    # Get current cursor position
    current_x=$(xdotool getmouselocation | awk -F '[: ]' '{print $2}')
    current_y=$(xdotool getmouselocation | awk -F '[: ]' '{print $4}')

    # If cursor moved, show it and reset tracking
    if [[ "$current_x" != "$last_x" || "$current_y" != "$last_y" ]]; then
        hyprctl keyword cursor:inactive_timeout 0
        last_x=$current_x
        last_y=$current_y
    else
        # If cursor hasn't moved for IDLE_TIME, hide it
        hyprctl keyword cursor:inactive_timeout 1
    fi

    sleep 1
done
