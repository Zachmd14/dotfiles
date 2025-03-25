#!/bin/bash
BAR_HEIGHT=20  # Adjust according to your Polybar height
SCREEN_WIDTH=$(xrandr | grep '*' | awk '{print $1}' | cut -d 'x' -f1)  # Get screen width
# Function to slide the bar in
slide_in() {
    trayer --edge top --align left --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34 --height 22 --margin 5 &
    # sleep 0.1  # Wait for Polybar to start
    # xdo move -x 0 -y -$BAR_HEIGHT polybar  # Move Polybar off-screen
    # sleep 0.05
    # for i in $(seq 0 $BAR_HEIGHT); do
    #     xdo move -x 0 -y -$((BAR_HEIGHT - i)) polybar
    #     sleep 0.01  # Adjust speed here
    # done
}
# Function to slide the bar out
slide_out() {
    # for i in $(seq 0 $BAR_HEIGHT); do
    #     xdo move -x 0 -y -$i polybar
    #     sleep 0.01  # Adjust speed here
    # done
    killall trayer  # Kill Polybar after sliding out
}
# Toggle bar visibility
if pgrep -x "trayer" > /dev/null; then
    slide_out
else
    slide_in
fi
