#!/bin/sh
## temporarily disabled screensaver due to intel openGL bug *sigh*
# xscreensaver -no-splash &
eval `ssh-agent`
set | grep SSH > ~/.ssh/agent.env
~/projects/hacks/keyup.sh
thunar --daemon &
emacs --daemon &
# mpdscribble &
~/bin/randomfile -p ~/Pictures/wallpapers &
xset b off &
setxkbmap -option "ctrl:nocaps" &
## network-manager goodies
/usr/lib/notification-daemon/notification-daemon &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

DEFAULT_SESSION=stumpwm

case $1 in
stumpwm)
        exec ck-launch-session dbus-launch stumpwm
        ;;
xmonad)
        exec ck-launch-session dbus-launch xmonad
        ;;
twm)
        exec ck-launch-session dbus-launch twm
        ;;
*)
        exec ck-launch-session dbus-launch $DEFAULT_SESSION
        ;;
esac

trayer --SetDockType true --transparent true --expand false --align right &
nm-applet &
update-notifier &
