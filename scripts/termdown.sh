#!/bin/bash

# Ask the user for the countdown time
read -p "Enter the countdown time : " TIME

# Path to the WAV file
WAV_FILE="/home/zach/scripts/notification.wav"

# Start termdown and wait for it to finish
termdown $TIME

# Send a notification and send a Telegram message
notify-send "Timer ended" && /home/zach/.local/share/pipx/venvs/telegram-send/bin/telegram-send 'Timer ended'
