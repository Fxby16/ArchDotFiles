#!/bin/bash

# Get the name of the default sink
default_sink_name=$(pactl info | grep 'Default Sink' | cut -d: -f2 | xargs)

# Get the index of the default sink
default_sink_index=$(pactl list short sinks | grep "$default_sink_name" | awk '{print $1}')

# Get the mute status of the default sink
mute_status=$(pactl get-sink-mute "$default_sink_index" | grep -oP '(?<=Mute: )yes|no')

# Get the audio volume percentage for the default sink using its index
audio_percentage=$(pactl get-sink-volume "$default_sink_index" | grep -oP '\d+%' | head -1)

# Check if muted
if [ "$mute_status" = "no" ]; then
    echo " $audio_percentage"  # Display volume icon and percentage if not muted
else
    echo " Muted"  # Display mute icon and text if muted
fi