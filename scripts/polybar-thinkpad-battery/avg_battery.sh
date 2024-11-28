#!/bin/bash

#################
# This is the script that is on the bar
#################

# Get the current battery levels
bat1=$(cat /sys/class/power_supply/BAT0/capacity)
bat2=$(cat /sys/class/power_supply/BAT1/capacity)

# Define the weights for each battery capacity 
weight1=25  
weight2=75 

# Calculate the weighted average battery level 
total_weight=$((weight1 + weight2))
average=$(( (bat1 * weight1 + bat2 * weight2) / total_weight ))

### RÉGI MEGOLDÁS
# Calculate the average battery level
#average=$(( ($bat1 + $bat2) / 2 ))
###

# Get the charging status of each battery
status1=$(cat /sys/class/power_supply/BAT0/status)
status2=$(cat /sys/class/power_supply/BAT1/status)

# Check if any of the batteries is charging
charging=false
if [ "$status1" == "Charging" ] || [ "$status2" == "Charging" ]; then
  charging=true
fi

# Battery current watt usage
if [ $(cat /sys/class/power_supply/BAT1/power_now)  == 0 ]; then
 bat_watt=$"$(echo "scale=2; $(cat /sys/class/power_supply/BAT0/power_now)/1000000" | bc)W"
# bat_watt=$(awk '{print $1*10^-6 "W"}' /sys/class/power_supply/BAT0/power_now)
else
	bat_watt=$"$(echo "scale=2; $(cat /sys/class/power_supply/BAT1/power_now)/1000000" | bc)W"
	#bat_watt=$(awk '{print $1*10^-6.0f "W"}' /sys/class/power_supply/BAT1/power_now)
fi

# Get the AC adapter status
ac_status=$(cat /sys/class/power_supply/AC/online)

# Output the battery levels, charging status, and AC adapter status

## Charging and AC is connected -> Green display
if [ "$charging" == true ] && [ "$ac_status" == 1 ]; then
  echo "%{F#00ff00}↑%{F-}%{F#00ff00}%{F-}  $average% $bat_watt AC" 

## Not charging and AC is connected (so batteries at threshold) -> White display
elif [ "$charging" == false ] && [ "$ac_status" == 1 ]; then
  echo "%{F#FFFFFF}%{F-} $average% AC"  

## Average battery are under 20% -> Red display
elif [ "$average" -lt 21 ]; then
  echo "%{F#FF0000}%{F-} $average% $bat_watt"  

## Else discharging
else
  echo "%{F#FFAA00}%{F-} $average% $bat_watt" 
fi

#elif [ "$charging" == true ] && [ "$ac_status" == 0 ]; then
#  echo "Average battery level: $average%, charging, AC unplugged"
