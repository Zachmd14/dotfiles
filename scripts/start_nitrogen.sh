#!/bin/bash

# Start Nitrogen wallpaper manager
nitrogen --restore &

# Give Nitrogen some time to apply the wallpaper
sleep 1

# Check if the last session wallpaper file exists
if [ -f ~/.config/nitrogen/bg-saved.cfg ]; then
    # Apply the wallpaper from the last session
    nitrogen --restore
else
    echo "No previous wallpaper found."
fi

