#!/usr/bin/env bash

# Improved screen recording script with better process detection and error handling

# Function to check if wf-recorder is running
is_recorder_running() {
    # Use pgrep to find exact process name, avoiding false positives
    pgrep -x "wf-recorder" >/dev/null 2>&1
}

# Function to create directory if it doesn't exist
ensure_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir" || {
            notify-send -u critical "Error: Cannot create directory $dir"
            exit 1
        }
    fi
}

# Main script
if is_recorder_running; then
    # Stop recording
    notify-send -t 1000 "Screen Recording has been stopped"

    # Try SIGINT first (graceful stop), then SIGTERM if needed
    if ! killall -s INT -u "$USER" wf-recorder 2>/dev/null; then
        sleep 0.5
        killall -s TERM -u "$USER" wf-recorder 2>/dev/null
    fi

    # Wait a moment for process to terminate
    sleep 0.2

    # Double check and force kill if still running
    if is_recorder_running; then
        killall -s KILL -u "$USER" wf-recorder 2>/dev/null
    fi

else
    # Start recording
    notify-send -t 1000 "Screen Recording has been started"

    # Ensure videos directory exists
    video_dir="$HOME/Videos/Screen-Record"
    ensure_directory "$video_dir"

    # Generate filename with timestamp
    filename="$video_dir/$(date +%Y-%m-%d_%H-%M-%S).mp4"

    # Start recording with error handling
    if ! wf-recorder -f "$filename" -c h264_vaapi -d /dev/dri/renderD128; then
        notify-send -u critical "Error: Failed to start screen recording"
        exit 1
    fi
fi
