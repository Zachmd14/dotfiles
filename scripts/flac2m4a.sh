#!/bin/bash

# Directory containing FLAC files
input_dir="/home/zach/Music/flac"
# Directory to save M4A files
output_dir="/home/zach/Music/m4a"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through all FLAC files in the input directory
for flac_file in "$input_dir"/*.flac; do
    # Get the base name of the file (without the directory and extension)
    base_name=$(basename "$flac_file" .flac)
    # Define the output file path
    output_file="$output_dir/$base_name.m4a"
    # Convert the file
    ffmpeg -i "$flac_file" -c:a aac -b:a 192k "$output_file"
done

echo "Conversion completed."
