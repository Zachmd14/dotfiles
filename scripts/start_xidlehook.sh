#!/bin/bash
# ~/start_xidlehook.sh

xidlehook \
  --not-when-audio \
  --timer 240 \
    "~/scripts/lock.sh" \
    '' \
  --timer 1 \
    'echo "Resetting xidlehook timer"' \
    ''
