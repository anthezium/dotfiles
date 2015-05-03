#!/bin/bash

## Set up icon tray first so applets have somewhere to go
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --widthtype percent --width 10 --transparent true --alpha 0 --tint 0x00ff00 --height 20 &

# tray applet for networking
nm-applet --sm-disable &
#wicd-client -t &

# Load resources
xrdb -merge .Xresources

# set up custom X key bindings for volume control, etc.
xbindkeys &

# Set background color

xsetroot -solid black

# Set up screensaver

xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &
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

# start xmonad

# for xmonad
exec ${HOME}/.cabal/bin/xmonad

# for xfce4
#xfce4-panel &
#
#exec startxfce4
