#!/bin/bash

# Set theme and colors
rofi_theme="/home/zach/.config/rofi/config.rasi"
rofi_bg="#2E3440"
rofi_fg="#ECEFF4"

# Get battery information
BATTERY1=$(cat /sys/class/power_supply/BAT0/capacity) # external
BATTERY2=$(cat /sys/class/power_supply/BAT1/capacity)
STATE1=$(cat /sys/class/power_supply/BAT0/status)
STATE2=$(cat /sys/class/power_supply/BAT1/status)

# Format battery information for rofi
BATTERY_INFO="Internal  : $BATTERY1% ($STATE1)\nExternal  : $BATTERY2% ($STATE2)"

# Display rofi popup with battery information
echo -e "$BATTERY_INFO" | rofi -theme "$rofi_theme" -dmenu -location 3 -yoffset 40 -xoffset 10 -width 20 -lines 2 -font "Hack 10" -p "Battery Status" -color-window "$rofi_bg, $rofi_fg, $rofi_bg" -color-normal "$rofi_fg, $rofi_bg, $rofi_fg" -color-active "$rofi_bg, $rofi_fg, $rofi_bg"
