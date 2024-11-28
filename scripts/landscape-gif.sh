#!/bin/bash
random_gif=$(find ~/Pictures/gif/ -type f -name '*.gif' | shuf -n 1)
ffplay -autoexit -fs -loop 0 "$random_gif"

