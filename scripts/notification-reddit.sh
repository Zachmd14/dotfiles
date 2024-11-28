#!/bin/sh

URL="https://www.reddit.com/message/unread/.json?feed=2ad08fbc426abf0caa70927b170ab65bc8eb30b5&user=Mean-Presentation-80"
USERAGENT="polybar-scripts/notification-reddit:v1.0 u/Mean-Presentation-80"

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo "  $notifications"
else
    echo "  0"
fi
