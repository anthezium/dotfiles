#!/bin/bash

#MGR="xfce"
MGR="xmonad"

if [ "$MGR" = "xmonad" ]; then
  ## Set up icon tray first so applets have somewhere to go
  trayer --edge top --align right --SetDockType true --SetPartialStrut true \
   --expand true --widthtype percent --width 10 --transparent true --alpha 0 --tint 0x00ff00 --height 20 &
elif [ "$MGR" = "xfce" ]; then
  # for xfce4
  xfce4-panel &
fi

# tray applet for networking
#nm-applet --sm-disable --no-agent &
pkill nm-wrapplet || true
/home/theod/bin/nm-wrapplet &
#wicd-client --tray &
# Load resources
xrdb -merge .Xresources

# set up custom X key bindings for volume control, etc.
xbindkeys &

# Set background color

xsetroot -solid black

# Set up screensaver

xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &

# Caffeine to toggle off (or timer off) screen saver
caffeine &

# Set up power management tray icon
#sleep 3
#gnome-power-manger &
#xfce4-power-manager &
cbatticon &

#volume slider
# gnome-sound-applet &
volumeicon &

# don't screensaver/go to sleep while i'm watching stuff
${HOME}/git/lightsOn/lightsOn.sh &

# redshift to adjust color temperature based on time of day (latitude:longitude for Portland)
redshift -l 45.5231:122.6765 &

# start window manager
if [ "$MGR" = "xmonad" ]; then
  # for xmonad
  #exec ${HOME}/.cabal/bin/xmonad
  #exec xmonad 
  exec ${HOME}/.xmonad/xmonad-x86_64-linux
elif [ "$MGR" = "xfce" ]; then
  # for xfce4
  exec startxfce4
fi
