#!/bin/bash

# Function to handle clean exit on user interruption
trap "echo 'Exiting...'; exit" SIGINT SIGTERM

# Loop until manually stopped
while true; do
    echo "Switching to 'light_work' mode..."
    uairctl jump lwork
    uairctl toggle
    echo "Working for 25 minutes..."
		sleep $(( (25 * 60) + 5 )) # 1 minute + 5 seconds

    echo "Switching to 'light_rest' mode..."
    uairctl jump lrest
    uairctl toggle
    echo "Resting for 5 minutes..."
		sleep $(( (5 * 60) + 5 )) # 1 minute + 5 seconds
	
done
