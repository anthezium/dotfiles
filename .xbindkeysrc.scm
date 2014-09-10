(xbindkey '("XF86AudioRaiseVolume") "amixer -c 0 sset 'Master',0 2dB+")
(xbindkey '("XF86AudioLowerVolume") "amixer -c 0 sset 'Master',0 2dB-")
(xbindkey '("XF86AudioMute") "amixer set Master toggle")
(xbindkey '("XF86AudioMicMute") "amixer set Capture toggle") 
