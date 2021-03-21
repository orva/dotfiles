#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

HOST=$(cat /etc/hostname)
CONF="$HOME/.config/swaybar-data/$HOST.toml"
GENERATOR="$HOME/bin/swaybar-data"

if [[ $HOST = "papaya" ]]; then
    $GENERATOR --config="$CONF"
elif [[ $HOST = "kisubox" ]]; then
    $GENERATOR --config="$CONF"
else
    while true; do
        DATE=$(date +'%a %Y-%m-%d - %k:%M')
        BAT=$(cat /sys/class/power_supply/BAT0/capacity)

        CONNECTIONS=""
        NMCLI_OUT=$(nmcli --terse --fields 'state,type,connection' device)
        while read -r CONN_LINE
        do
          STATE=""
          TYPE=""
          CONN=""
          IFS=: read -r STATE TYPE CONN <<< "$CONN_LINE"

          if [ "$STATE" != "connected" ]; then
            continue
          fi

          STATUS=""
          if [ "$TYPE" = "ethernet" ]; then
            STATUS="$TYPE"
          else
            STATUS="$TYPE:$CONN"
          fi

          if [ "$CONNECTIONS" = "" ]; then
            CONNECTIONS="$STATUS"
          else
            CONNECTIONS="${CONNECTIONS} | ${STATUS}"
          fi
        done <<< "$NMCLI_OUT"

        echo "${CONNECTIONS} | BAT: ${BAT}% | ${DATE} "
        sleep 5
    done
fi
