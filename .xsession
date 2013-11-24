#!/bin/bash

## Set up icon tray first so applets have somewhere to go
~/git/trayer-srg/trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --widthtype percent --width 10 --transparent true --alpha 0 --tint 0x00ff00 --height 20 &

# Load resources
xrdb -merge .Xresources

# Set background color

xsetroot -solid black

# Set up screensaver

xscreensaver -no-splash &

# tray applet for networking
nm-applet --sm-disable &
#wicd-client -t &

# Set up power management tray icon
#sleep 3
#gnome-power-manger &
#xfce4-power-manager &

#volume slider
gnome-sound-applet &

# start xmonad

exec xmonad
