#!/bin/sh
## temporarily disabled screensaver due to intel openGL bug *sigh*
# xscreensaver -no-splash &
eval `ssh-agent`
set | grep SSH > ~/.ssh/agent.env
~/projects/scripts/keyup.sh
thunar --daemon &
emacs --daemon &
# mpdscribble &
~/builds/bin/randomfile -p ~/images/wallpapers &
xset b off &
setxkbmap -option "ctrl:nocaps" &

DEFAULT_SESSION=stumpwm

case $1 in
stumpwm)
	exec ck-launch-session dbus-launch stumpwm
	;;
twm)
        exec ck-launch-session dbus-launch twm
        ;;
*)
	exec ck-launch-session dbus-launch $DEFAULT_SESSION
	;;
esac
