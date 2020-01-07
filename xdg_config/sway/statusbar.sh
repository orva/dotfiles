#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

HOST=$(cat /etc/hostname)

while true; do
    if [[ $HOST = "workhorse" ]]; then
        DATE=$(date +'%a %Y-%m-%d - %k:%M')
        BAT=$(cat /sys/class/power_supply/BAT0/capacity)
        echo "BAT: $BAT% | $DATE "
        sleep 15
    elif [[ $HOST = "papaya" ]]; then
        DATE=$(date +'%a %Y-%m-%d - %k:%M')
        BAT=$(cat /sys/class/power_supply/BAT1/capacity)
        echo "BAT: $BAT% | $DATE "
        sleep 15
    elif [[ $HOST = "kisubox" ]]; then
        DATE=$(date +'%a %Y-%m-%d - %k:%M:%S ')
        echo "$DATE"
        sleep 1
    fi
done

