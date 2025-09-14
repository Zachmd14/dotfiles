#!/bin/bash

# List of apps to manage
APPS=("anki" "obsidian" "vesktop")

# Function to kill all apps
kill_apps() {
    for app in "${APPS[@]}"; do
        pkill -f "$app" 2>/dev/null
    done
}

# Function to check if any app is running
any_app_running() {
    for app in "${APPS[@]}"; do
        if pgrep -f "$app" >/dev/null; then
            return 0 # true - at least one app is running
        fi
    done
    return 1 # false - no apps running
}

# If any app is already running, kill all apps and exit
if any_app_running; then
    kill_apps
    exit 0
fi

# If no apps are running, proceed with normal execution
if hyprctl monitors | grep -q "DP-1"; then
    hyprctl dispatch exec "[workspace 14] anki"
    hyprctl dispatch exec "[workspace 13] obsidian"
    hyprctl dispatch exec "[workspace 1] vesktop"
    exit 0
else
    hyprctl dispatch exec "[workspace 4] anki"
    hyprctl dispatch exec "[workspace 3] obsidian"
    hyprctl dispatch exec "[workspace 1] vesktop"
    exit 1
fi
