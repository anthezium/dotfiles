#!/bin/bash

echo "xsession run" > ~/xsession_run

# start policykit, so tray apps can do privileged things
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

## Set up icon tray first so applets have somewhere to go
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --widthtype percent --width 10 --transparent true --alpha 0 --tint 0x00ff00 --height 20 &

# Load resources
xrdb -merge .Xresources

# Set background color

xsetroot -solid black

# Set up screensaver

xscreensaver -no-splash &

nm-applet --sm-disable &

# Set up power management tray icon
#sleep 3
#gnome-power-manger &
xfce4-power-manager &

#volume slider
gnome-sound-applet &

# start xmonad

#exec /home/ted/.cabal/bin/xmonad
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session x-window-manager
exec dbus-launch --sh-syntax --exit-with-session x-window-manager
