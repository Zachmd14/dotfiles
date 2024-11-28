#!/bin/bash

# Ask for the note title
read -p "Enter the note title: " note_title

# Replace spaces with underscores and convert to lowercase for the filename
file_name=$(echo "$note_title" | tr ' ' '_' | tr '[:upper:]' '[:lower:]').md

# Specify the directory where you want to save the file
directory="/home/zach/mainVault/02 - Zettelkasten/"

# Create the file with the given name in the specified directory
touch "$directory/$file_name"

# Open the new file in neovim
nvim "$directory/$file_name"
