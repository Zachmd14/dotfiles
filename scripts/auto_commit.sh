#!/bin/bash

# Set the directory you want to monitor
DIRECTORY="/home/zach/Documents/Obsidian/"

# Change to the specified directory
cd "$DIRECTORY" || exit

# Configure Git to use the merge strategy when pulling
git config pull.rebase false

# Infinite loop to repeatedly check for changes and commit them
while true; do
    # Fetch and merge any new changes from the remote repository
    git pull origin master

    # Add any new or changed files to the staging area
    git add .

    # Check if there are any changes to commit
    if ! git diff-index --quiet HEAD; then
        # Commit the changes with the current time as the message
        git commit -m "Auto-commit on $(date '+%Y-%m-%d %H:%M:%S')"

        # Push the changes to the remote repository
        git push origin master
    fi

    # Wait for 2 minutes before checking again
    sleep 120
done

