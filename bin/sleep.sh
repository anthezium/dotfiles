#!/bin/bash
#if [ "$1" = "pre" ]; then
#	#killall -9 wpa_supplicant #nm-applet bug's workaround
#fi

# goes in /usr/lib/systemd/system-sleep/sleep.sh
set -x

if [ "$1" = "post" ]; then
  /sbin/modprobe -rvf iwldvm
  /sbin/modprobe -rvf iwlwifi
  /sbin/modprobe -v iwldvm
  /sbin/modprobe -v iwlwifi
  systemctl restart NetworkManager.service
  pkill nm-applet
  sudo -u theod env DISPLAY=:0 XAUTHORITY=/home/theod/.Xauthority nm-applet --sm-disable &
fi
