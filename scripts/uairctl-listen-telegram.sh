#!/usr/bin/env fish

# Loop to listen to uairctl and send the output to Telegram every second
while true
    # Capture output from uairctl for 1 second and remove null bytes
    set output (timeout 1 uairctl listen | tr -d '\0' | head -n 1)

    # Check if the output is empty
    if test -z "$output"
        continue
    end

    # Prepend /silent to the output
    set message "/silent $output"

    # Send the message using telegram-send
    telegram-send "$message"

end

