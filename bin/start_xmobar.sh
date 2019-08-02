#!/bin/bash

pgrep xmobar &> /dev/null && killall xmobar
#$HOME/.cabal/bin/xmobar $@
xmobar $@
