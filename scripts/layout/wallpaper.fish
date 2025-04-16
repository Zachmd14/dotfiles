#!/usr/bin/fish

# Configuration
set WALLPAPER_DIR "$HOME/Pictures/wallpaper/gruvbox-paintings/"  # Directory containing wallpapers
set SCREEN_MODE "--set-zoom-fill"              # Other options: --set-tiled, --set-scaled

# Check if Nitrogen is installed
if not command -q nitrogen
    echo "Error: nitrogen is not installed. Please install it first."
    exit 1
end

# Validate wallpaper directory
if not test -d "$WALLPAPER_DIR"
    echo "Error: Directory $WALLPAPER_DIR does not exist."
    exit 1
end

# Get list of wallpapers (supports jpg, png, webp)
set WALLPAPERS $WALLPAPER_DIR/*.{jpg,jpeg,png,webp}
if test (count $WALLPAPERS) -eq 0
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
end

# Pick a random wallpaper
set RANDOM_WALLPAPER $WALLPAPERS[(random 1 (count $WALLPAPERS))]

# Apply the same wallpaper to all three screens
for SCREEN in 0 1 2
    nitrogen $SCREEN_MODE --head=$SCREEN "$RANDOM_WALLPAPER" >/dev/null 2>&1
end

echo "Set wallpaper: "(basename "$RANDOM_WALLPAPER")" on screens 0, 1, and 2"
