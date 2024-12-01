
#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -t HH:MM -m \"Reminder message\""
    echo "Example: $0 -t 15:30 -m \"Meeting with team\""
    exit 1
}

# Parse command-line options
while getopts "t:m:" opt; do
    case $opt in
        t) TIME="$OPTARG" ;;
        m) MESSAGE="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check if both time and message are provided
if [ -z "$TIME" ] || [ -z "$MESSAGE" ]; then
    usage
fi

# Validate time format HH:MM
if ! [[ "$TIME" =~ ^([0-1][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
    echo "Invalid time format. Use HH:MM (24-hour format)."
    exit 1
fi

# Extract hours and minutes
HOUR=${TIME%:*}
MINUTE=${TIME#*:}

# Calculate seconds until the target time
CURRENT_TIME=$(date +%s)
TARGET_TIME=$(date -d "$HOUR:$MINUTE" +%s)

# Abort if the time is in the past
if [ $TARGET_TIME -lt $CURRENT_TIME ]; then
    echo "Error: Specified time ($TIME) is in the past. Please provide a future time."
    exit 1
fi

# Calculate seconds to wait
SECONDS_UNTIL=$((TARGET_TIME - CURRENT_TIME))

# Detach from terminal and redirect output
{
    echo "Reminder scheduled for $TIME: \"$MESSAGE\""
    sleep $SECONDS_UNTIL
    notify-send "Reminder" "$MESSAGE" && /home/zach/.local/share/pipx/venvs/telegram-send/bin/telegram-send "Arch Reminder: $MESSAGE" && paplay /home/zach/scripts/notification.wav
} &> /dev/null &

