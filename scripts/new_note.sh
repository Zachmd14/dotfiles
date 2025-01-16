#!/bin/bash

# Ask for the note title
read -p "Enter the note title: " note_title

# Replace spaces with underscores and convert to lowercase for the filename
file_name=$(echo $note_title | tr ' ' '-' | tr '[:upper:]' '[:lower:]').md

# Define the 6 directories
directories=(
  "~/Documents/Obsidian/mainVault/1. Rough Notes/"
  "~/Documents/Obsidian/mainVault/2. Ressources/"
	"~/Documents/Obsidian/mainVault/3. Tags/"
  "~/Documents/Obsidian/mainVault/4. Indexes/"
  "~/Documents/Obsidian/mainVault/5. Full Notes/"
  "~/Documents/Obsidian/mainVault/6. School/"
)

# Display the options
echo "Choose a directory to save the note:"
for i in "${!directories[@]}"; do
  echo "$((i + 1))) ${directories[$i]}"
done

# Ask the user to select a directory
while true; do
  read -p "Enter the number (1-6): " choice
  if [[ "$choice" -ge 1 && "$choice" -le 6 ]]; then
    directory="${directories[$((choice - 1))]}"
    break
  else
    echo "Invalid choice. Please enter a number between 1 and 6."
  fi
done

# Create the file with the given name in the chosen directory
touch "$directory/$file_name"

# Open the new file in neovim
nvim "$directory/$file_name"

