#!/bin/bash

# Get the default sink name
default_sink_name=$(pactl get-default-sink)

# If no default sink is found, exit with an error
if [ -z "$default_sink_name" ]; then
    echo "No audio sink found."
    exit 1
fi

# Get the mute status of the default sink
mute_status=$(pactl get-sink-mute "$default_sink_name" | grep -oP '(?<=Mute: )yes|no')

# Get the audio volume percentage for the default sink
audio_percentage=$(pactl get-sink-volume "$default_sink_name" | grep -oP '\d+%' | head -1)

# Display volume or mute icon
if [ "$mute_status" = "no" ]; then
    echo " $audio_percentage"  # Display volume icon and percentage if not muted
else
    echo " Muted"  # Display mute icon and text if muted
fi

