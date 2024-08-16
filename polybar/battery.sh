#!/bin/bash

battery="BAT1"
adapter="ACAD"
full_at=100

battery_percentage=$(cat /sys/class/power_supply/$battery/capacity)
charging_status=$(cat /sys/class/power_supply/$adapter/online)

icon=""

quarter=$((full_at / 4))
if (( battery_percentage <= quarter )); then
    icon=""
elif (( battery_percentage <= quarter * 2 )); then
    icon=""
elif (( battery_percentage <= quarter * 3 )); then
    icon=""
else
    icon=""
fi

if (( charging_status == 1 )); then
    icon=""
fi

awk -v icon="$icon" -v percentage="$battery_percentage" 'BEGIN {
    if (percentage <= 5)
        color="%{F#FF0000}"; # Red
    else if (percentage <= 20)
        color="%{F#FFAE00}"; # Orange
    else
        color="%{F#FFFFFF}"; # White or default color

    printf color icon " " percentage "%%%{F-}";
}'