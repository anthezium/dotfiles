import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

gimp = withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full

main = do
  xmobarProc <- spawnPipe "/home/ted/bin/start_xmobar.sh /home/ted/.xmobarrc"
  xmonad $ defaultConfig 
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  (onWorkspace "gimp" gimp) $ layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmobarProc
        , ppTitle = xmobarColor "green" "" . shorten 50
        }
    , modMask = mod1Mask
    , terminal = "xterm"
    } `additionalKeys` 
    [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((0, xK_Print), spawn "scrot '%Y-%m-%d_$wx$h_full.png' -e 'mv $f ~/screenshots/'") --screenshot
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s '%Y-%m-%d_$wx$h_window.png' -e 'mv $f ~/shots/'") --windowshot
    , ((mod1Mask, xK_Left), prevWS)
    , ((mod1Mask, xK_Right), nextWS)
    , ((mod1Mask .|. shiftMask , xK_Left), shiftToPrev)
    , ((mod1Mask .|. shiftMask , xK_Right), shiftToNext)
    ]
