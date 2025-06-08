#!/bin/bash

# Navigate to your repo directory if needed
cd /home/zach/Documents/Emacs/org-roam/

# Pull the latest changes
git pull origin "$(git rev-parse --abbrev-ref HEAD)"

# Add all changes
git add .

# Create commit message with date and time
datetime=$(date '+%Y-%m-%d %H:%M')
git commit -m "Update on $datetime"

# Push changes
git push origin "$(git rev-parse --abbrev-ref HEAD)"
