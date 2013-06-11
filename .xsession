#!/bin/bash

## wrap in a GNOME session and run this script again with SESSION_MANAGER set
#if [ -z "$SESSION_MANAGER" ]; then
#
#
#  [ -d ~/.config/autostart ] || mkdir ~/.config/autostart
#  rm -f ~/.config/autostart/*
#  cat <<EOF > ~/.config/autostart/xsession.desktop
#[Desktop Entry]
#Name=Xsession
#Comment=Start .xsession
#Exec=$(readlink -f $0)
#Type=Application
#X-GNOME-Autostart-enabled=true
#EOF
#  exec gnome-session --autostart=$HOME/.config/autostart
#fi
## Set up icon tray first so applets have somewhere to go
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --widthtype percent --width 10 --transparent true --tint 0x191970 --height 20 &

# Load resources
xrdb -merge .Xresources

# Set background color

xsetroot -solid midnightblue

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

exec /home/ted/.cabal/bin/xmonad
