#!/bin/bash

if [[ $1 == "next" ]]; then
    # Command to go to the next workspace
    i3-msg workspace next
elif [[ $1 == "prev" ]]; then
    # Command to go to the previous workspace
    i3-msg workspace prev
else
    echo "Usage: $0 [next|prev]"
fi

