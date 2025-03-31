#!/bin/bash

# Path to the grayscale shader
SHADER_PATH="/home/zach/dotfiles/.config/picom/greyscale.glsl"

# Function to force redraw of all visible windows
force_redraw() {
    for win in $(xwininfo -root -children | awk '/0x/{print $1}'); do
        xdotool windowmap "$win"
    done
}

# Check if picom is running with the grayscale shader
if pgrep -f "picom --backend glx --window-shader-fg $SHADER_PATH" > /dev/null; then
    # If picom is in grayscale mode, kill it and start in normal mode
    pkill picom
    picom &
		nitrogen --set-tiled ~/Pictures/wallpaper/kanagawa-godzilla.png
else
    # If picom is not in grayscale mode, kill it and start in grayscale mode
    pkill picom
    picom --backend glx --window-shader-fg "$SHADER_PATH" &
		# nitrogen --set-tiled ~/Pictures/wallpaper/GdErUjnXAAAsR7i.jpg
		nitrogen --set-tiled ~/Pictures/wallpaper/GdErUjnXAAAsR7i.jpg
fi

# Force a redraw of all visible windows to apply the changes
force_redrawi
