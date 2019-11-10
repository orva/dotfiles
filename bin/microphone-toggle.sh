#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SOURCES=$(pactl list short sources | cut -f 1)
while read -r SOURCE
do
    pactl set-source-mute "$SOURCE" toggle
done <<< "$SOURCES"

