#!/bin/bash
# Get memory usage with decimals in gigabytes without 'GiB' unit
used=$(free -m | awk '/^Mem:/ {printf "%.2f", $3/1024}')
total=$(free -m | awk '/^Mem:/ {printf "%.2f", $2/1024}')
echo "$used""G"