#!/bin/bash

# TODO use this in a loop that runs it every time a ping to
# the default gateway times out.

set -x

IF="wlp3s0"
AF="/sys/class/net/${IF}/address"
MAC="$((tr -d ':' | tr '[:lower:]' '[:upper:]') < ${AF})"
MAC1="$(echo "obase=16;ibase=16;${MAC} + 1" | bc | tr '[:upper:]' '[:lower:]' | sed 's/\(..\)/\1:/g;s/:$//')"
CON="$(nmcli con | grep ${IF} | awk 'BEGIN { FS = "  " } ; { print $1 }')"

sudo bash -x <<EOF
nmcli con down id "${CON}" && \
ip link set dev ${IF} down && \
ip link set dev ${IF} address ${MAC1} && \
ip link set dev ${IF} up && \
nmcli con up id "${CON}"
EOF
