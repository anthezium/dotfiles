import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

--gimp = withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full

myModMask = mod4Mask

main = do
  xmobarProc <- spawnPipe "~/bin/start_xmobar.sh ~/.xmobarrc"
  xmonad $ docks defaultConfig --gnomeConfig to manage windows for Gnome
    { manageHook = manageDocks <+> manageHook defaultConfig
    , handleEventHook = fullscreenEventHook
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    -- for BSP
    --, layoutHook = desktopLayoutModifiers $ emptyBSP
    , logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmobarProc
        , ppTitle = xmobarColor "green" "" . shorten 50
        }
    , modMask = myModMask
    , terminal = "xterm"
    , borderWidth = 0
    } `additionalKeys` 
    [ ((myModMask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((0, xK_Print), spawn "scrot '%Y-%m-%d-%s_$wx$h_full.png' -e 'mv $f ~/screenshots/'") --screenshot
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s '%Y-%m-%d-%s_$wx$h_window.png' -e 'mv $f ~/screenshots/'") --windowshot
    , ((myModMask, xK_Left), prevWS)
    , ((myModMask, xK_Right), nextWS)
    , ((myModMask .|. shiftMask , xK_Left), shiftToPrev)
    , ((myModMask .|. shiftMask , xK_Right), shiftToNext)
    , ((myModMask, xK_Home), spawn "vlc --meta-title projector")
    , ((myModMask, xK_r), sendMessage Rotate)
    , ((myModMask, xK_s), sendMessage Swap)
    ]
