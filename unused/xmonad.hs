import XMonad
import IO (Handle, hPutStrLn)
import System.Exit
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask,               xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask .|. shiftMask, xK_e	), spawn "emacs")
    , ((modMask .|. shiftMask, xK_t     ), spawn "urxvt -e emacs -nw")
    , ((modMask .|. shiftMask, xK_r	), spawn "gmrun")
    , ((modMask .|. shiftMask, xK_s	), spawn "sonata")
    , ((modMask .|. shiftMask, xK_p	), spawn "pidgin")
    , ((modMask .|. shiftMask, xK_f	), spawn "thunar")
    , ((modMask .|. shiftMask, xK_w	), spawn "firefox")
    , ((modMask .|. shiftMask, xK_n	), spawn "/usr/lib/wicd/gui.py")
    , ((modMask .|. shiftMask, xK_v	), spawn "VirtualBox")
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_n     ), refresh)
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_e     ), windows W.focusDown)
    , ((modMask,               xK_Right ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp  )
    , ((modMask,               xK_Left  ), windows W.focusUp  )
    , ((modMask,               xK_m     ), windows W.focusMaster  )
    , ((modMask .|. shiftMask, xK_Return), windows W.shiftMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
    , ((modMask              , xK_g     ), sendMessage ToggleStruts)
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ),
          broadcastMessage ReleaseResources >> restart "xmonad" True)
    ]
    ++
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
 
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
    ]
 
myLayout = avoidStruts (tall ||| Mirror tall ||| Full)
  where
     tall   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 2/100
 
myManage = manageHook defaultConfig <+> manageDocks

main = do h <- spawnPipe "xmobar"
          xmonad $ withUrgencyHook NoUrgencyHook defaultConfig {
	               terminal           = "urxvt",
                       focusFollowsMouse  = True,
                       borderWidth        = 1,
                       workspaces         = ["1:browser","2:code","3:admin","4:people","5:music","6","7","8","9"],
                       normalBorderColor  = "#000000",
                       focusedBorderColor = "#ff0000",
 
                       -- key bindings
                       keys               = myKeys,
                       mouseBindings      = myMouseBindings,
 
                       -- hooks, layouts
                       layoutHook         = myLayout,
                       manageHook         = myManage,
		       logHook		  = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn h ,
                                                                          ppUrgent = xmobarColor "yellow" "red" }
				 }
