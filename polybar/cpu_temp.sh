#!/bin/bash

# Extract the CPU temperature using the sensors command
cpu_temp=$(sensors k10temp-pci-00c3 | grep 'Tctl:' | awk '{print $2}')

# Remove '+' sign if present
cpu_temp=${cpu_temp//+/}

# Use awk to add temperature icon depending on temperature level
echo "$cpu_temp" | awk '{
    if ($1 >= 90) icon=" ";
    else if ($1 >= 75) icon=" ";
    else if ($1 >= 60) icon=" ";
    else if ($1 >= 50) icon=" ";
    else icon=" ";
    if ($1 >= 75) print "%{F#FF0000}" icon $1 "%{F-}";
    else print icon $1;
}'