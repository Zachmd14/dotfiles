#!/bin/bash

# Create a new tmux session named "services" without attaching to it
tmux new-session -d -s services -n apps

# Change directory to ~/Apps/ in the first window (window 0)
tmux send-keys -t services:0 'cd ~/Apps/' C-m

# Create second window and run 'uair'
tmux new-window -t services -n uair
tmux send-keys -t services:1 'uair' C-m

# Optional: Select the first window and attach to the session
tmux attach-session -t services
