#!/bin/bash

while true; do
	clear && ssh -t zach@88.170.165.245 -p 32768 timew summary :ids 
	sleep 5
done
