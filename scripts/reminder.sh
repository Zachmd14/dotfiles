#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [-t HH:MM | -d Xm] -m \"Reminder message\""
    echo "Examples:"
    echo "  $0 -t 15:30 -m \"Meeting with team\""
    echo "  $0 -d 5m -m \"Check the oven\""
    echo "  $0 -d 2h -m \"Long task reminder\""
    exit 1
}

# Parse command-line options
while getopts "t:d:m:" opt; do
    case $opt in
        t) TIME="$OPTARG" ;;
        d) DURATION="$OPTARG" ;;
        m) MESSAGE="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check if message is provided and either time or duration is provided
if [ -z "$MESSAGE" ] || { [ -z "$TIME" ] && [ -z "$DURATION" ]; }; then
    usage
fi

# Check that both time and duration aren't provided
if [ -n "$TIME" ] && [ -n "$DURATION" ]; then
    echo "Error: Please specify either time (-t) or duration (-d), not both."
    exit 1
fi

# Calculate seconds until the target time
if [ -n "$TIME" ]; then
    # Validate time format HH:MM
    if ! [[ "$TIME" =~ ^([0-1][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
        echo "Invalid time format. Use HH:MM (24-hour format)."
        exit 1
    fi

    # Extract hours and minutes
    HOUR=${TIME%:*}
    MINUTE=${TIME#*:}

    CURRENT_TIME=$(date +%s)
    TARGET_TIME=$(date -d "$HOUR:$MINUTE" +%s)

    # Abort if the time is in the past
    if [ $TARGET_TIME -lt $CURRENT_TIME ]; then
        echo "Error: Specified time ($TIME) is in the past. Please provide a future time."
        exit 1
    fi

    SECONDS_UNTIL=$((TARGET_TIME - CURRENT_TIME))
    REMINDER_TIME_DESC="$TIME"
else
    # Validate duration format (e.g., 5m, 2h, 30s)
    if ! [[ "$DURATION" =~ ^[0-9]+[smh]$ ]]; then
        echo "Invalid duration format. Use Xs, Xm, or Xh (seconds, minutes, hours)."
        exit 1
    fi

    UNIT=${DURATION: -1}
    VALUE=${DURATION%?}

    case $UNIT in
        s) SECONDS_UNTIL=$VALUE ;;
        m) SECONDS_UNTIL=$((VALUE * 60)) ;;
        h) SECONDS_UNTIL=$((VALUE * 3600)) ;;
    esac

    REMINDER_TIME_DESC="in $DURATION"
fi

# Detach from terminal and redirect output
{
    echo "Reminder scheduled for $REMINDER_TIME_DESC: \"$MESSAGE\""
    sleep $SECONDS_UNTIL
    notify-send "Reminder" "$MESSAGE" && 
        /home/zach/.local/share/pipx/venvs/telegram-send/bin/telegram-send "Arch Reminder: $MESSAGE" && 
        paplay /home/zach/scripts/notification.wav
} &> /dev/null &
