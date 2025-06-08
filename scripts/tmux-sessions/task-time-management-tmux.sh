#!/bin/bash

SESSION_NAME="task-time"

# Check if the session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "Session $SESSION_NAME already exists. Attaching to it."
    tmux attach-session -t $SESSION_NAME
else
	tmux new-session -d -s $SESSION_NAME
	tmux send-keys "~/scripts/task-refresh.sh" C-m
	tmux split-window -t 1 -v
	tmux split-window -t 1 -h
	tmux send-keys "~/scripts/time-refresh.sh" C-m
	tmux select-pane -t 3
	tmux split-pane -h
	# tmux resize-pane -x 39 -y 24
	tmux send-keys "~/scripts/task-burndow-refresh.sh" C-m
	tmux select-pane -t 3
	tmux resize-pane -t 4 -x 20 -y 20
	tmux resize-pane -t 2 -x 65 -y 24
	tmux attach-session -t $SESSION_NAME
fi
