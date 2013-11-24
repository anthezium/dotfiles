#!/bin/bash

pgrep xmobar &> /dev/null && killall xmobar
xmobar $@
