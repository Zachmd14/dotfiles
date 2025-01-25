#!/bin/bash
# Start a new tmux session
tmux new-session -s c-coding -n editor -d

# Split the window into panes
tmux new-window -t c-coding -n compiler
tmux new-window -t c-coding -n runner

# Split compiler widow horizontally
tmux split-window -t c-coding:compiler

# Assign tasks to each pane
tmux send-keys -t c-coding:editor 'cd /home/zach/Documents/GitHub/ && cd "$(find . -maxdepth 1 -type d | fzf --height=90%)" && clear && exa --icons --group-directories-first --sort=extension' C-m

# Attach to the session
tmux attach-session -t c-coding
