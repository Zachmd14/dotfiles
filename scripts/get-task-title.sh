#!/bin/bash
jq -r '.text | split(",")[0] | sub("^[0-9]+ "; "")' ~/.cache/waybar-tasks.json
