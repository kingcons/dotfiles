import XMonad
import IO (Handle, hPutStrLn)
import System.Exit
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- TODO:
-- Dual Monitor Tweaks
-- Status Bar Notifications for IRC/Jabber
-- Finalize Super/Meta split.
-- Add some lambda.txt magic?

myKeys = [
  ("M-q", io (exitWith ExitSuccess)),
  ("M1-<Tab>", cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab),
  ("M-k", kill),
  ("M-e", spawn "emacsclient -c"),
  ("M-w", spawn "conkeror"),
  ("M-c", spawn "chromium"),
  ("M-t", spawn "urxvt"),
  ("M-r", spawn "gmrun"),
  ("M-b", spawn "~/bin/randomfile -p ~/Pictures/wallpapers"),
  ("M-a", spawn "urxvt -e rlwrap sbcl --eval '(ql:quickload :shuffletron)' --eval '(shuffletron:run)'"),
  ("M-m", spawn "smplayer"),
  ("M-s", spawn "scrot -d 5 '%Y-%m-%d.png' -e 'mv $f ~/images/screenshots/'"),
  ("M-f", spawn "thunar"),
  ("M-v", spawn "VirtualBox"),
  ("M-<space>", sendMessage NextLayout),
  ("M-n", refresh),
  ("M-S-<return>", windows W.shiftMaster),
  ("M-h", sendMessage Shrink),
  ("M-l", sendMessage Expand),
  ("M-S-q", broadcastMessage ReleaseResources >> restart "xmonad" True)
  ]

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
    ]

myLayout = avoidStruts (tall ||| Mirror tall ||| Full)
  where
     tall = Tall nmaster delta ratio
     nmaster = 1
     ratio = 1/2
     delta = 2/100

main = do status <- spawnPipe "xmobar"
          xmonad $ defaultConfig {
            modMask = mod4Mask,
            terminal = "urxvt",
            focusFollowsMouse = True,
            borderWidth = 1,
            workspaces = ["1:browser","2:todo","3:admin","4:people","5:music","6:work","7:play","8","9"],
            normalBorderColor = "#000000",
            focusedBorderColor = "#ff0000",
            mouseBindings = myMouseBindings,
            layoutHook = myLayout,
            manageHook = manageHook defaultConfig <+> manageDocks,
            logHook = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn status,
                                                    ppUrgent = xmobarColor "yellow" "red" }
          } `additionalKeysP` myKeys
