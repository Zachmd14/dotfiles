#!/bin/bash

# Ask the user for the countdown time
read -p "Enter the countdown time : " TIME

# Path to the WAV file
WAV_FILE="/home/zach/scripts/notification.wav"

# Start termdown and wait for it to finish
termdown $TIME

# Send a notification and send a Telegram message
notify-send "Timer ended" && /usr/bin/telegram-send 'Timer ended' && paplay /home/zach/scripts/notification.wav
