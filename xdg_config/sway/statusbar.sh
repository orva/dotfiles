#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

HOST=$(cat /etc/hostname)
CONF="$HOME/.config/swaybar-data/$HOST.toml"
GENERATOR="$HOME/bin/swaybar-data"

if [[ $HOST = "workhorse" ]]; then
    while true; do
        DATE=$(date +'%a %Y-%m-%d - %k:%M')
        BAT=$(cat /sys/class/power_supply/BAT0/capacity)
        echo "BAT: $BAT% | $DATE "
        sleep 15
    done
elif [[ $HOST = "papaya" ]]; then
    $GENERATOR --config="$CONF"
elif [[ $HOST = "kisubox" ]]; then
    $GENERATOR --config="$CONF"
fi
