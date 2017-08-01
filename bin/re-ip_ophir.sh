#!/bin/bash

#set -x
set -e

IP=$(dig +short myip.opendns.com @resolver1.opendns.com | grep '[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+')

LASTF=/home/srv/ophir_last_ip

update() {
  ssh -p10771 root@ophir "sudo /home/theod/bin/update_ip.sh $IP"
  echo "$IP" > $LASTF
}

if [ -n "$IP" ]; then
  if [ -f "$LASTF" ]; then
    LAST="$(grep '[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+' $LASTF)"
    if [ "$IP" != "$LAST" ]; then
      update
    fi
  else
    update
  fi
fi
