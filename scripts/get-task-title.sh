#!/bin/bash
ssh zach@88.170.165.245 -p 32768 jq -r '.text | split(",")[0] | sub("^[0-9]+ "; "")' ~/.cache/waybar-tasks.json
