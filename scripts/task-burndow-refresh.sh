#!/bin/bash

while true; do
	clear && ssh -t zach@88.170.165.245 -p 32768 task rc._forcecolor=on burndown.daily
	sleep 5
done
