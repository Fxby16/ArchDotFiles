#!/usr/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload MyBar &
  done
else
  polybar --reload MyBar &
fi
