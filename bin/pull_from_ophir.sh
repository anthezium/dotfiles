#!/bin/bash


host=ophir

trap "rm -f /tmp/synctorrent.lock" SIGINT SIGTERM

if [ -e /tmp/synctorrent.lock ]
then
  echo "Synctorrent is running already."
  exit 1
else

  touch /tmp/synctorrent.lock

  umask 0002
  lftp sftp://$host << EOF
  set ftp:ssl-allow yes
  set mirror:use-pget-n 10
  set mirror:exclude-regex .*[cC]olbert.*$\|.*[dD]aily.[sS]how.*$\|.*[lL]ast.[wW]eek.[tT]onight.*[jJ]ohn.*[oO]liver.*$\|.*[sS]hadowhunters.[tT]he.[mM]ortal.[iI]nstruments.*$
  set xfer:log 1
  set xfer:log-file /home/srv/pull.log
  #set xfer:eta-period 30 # every 30 seconds
  #set xfer:rate-period 20 # average rate
  mirror -c -P5 --log=synctorrents.log /srv/media/shared /mnt/KingGhidora/media/shared
  mirror -c -P5 --log=synctorrents.log /srv/media/porn /mnt/KingGhidora/media/porn
  
  quit
EOF

  rm -f /tmp/synctorrent.lock
  exit 0

fi
