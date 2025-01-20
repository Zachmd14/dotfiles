#!/bin/bash

# Kill existing instances of Polybar
killall -q polybar

# Wait for Polybar to terminate
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar &
