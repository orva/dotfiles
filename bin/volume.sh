#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CMD="${1-unset}"
if [[ "$CMD" != "up" ]] && [[ "$CMD" != "down" ]] && [[ "$CMD" != "mute-toggle" ]]; then
    echo "usage: $0 [up|down|mute-toggle]"
    exit 1
fi

SINKS=$(pactl list short sinks | grep -v hdmi | cut -f 1)
while read -r SINK
do
    if [[ "$CMD" == "up" ]]; then
        pactl set-sink-mute "$SINK" 0
        pactl set-sink-volume "$SINK" +5%
    elif [[ "$CMD" == "down" ]]; then
        pactl set-sink-mute "$SINK" 0
        pactl set-sink-volume "$SINK" -5%
    elif [[ "$CMD" == "mute-toggle" ]]; then
        pactl set-sink-mute "$SINK" toggle
    fi
done <<< "$SINKS"
