#!/bin/sh
## temporary disabled screensaver due to intel openGL bug *sigh*
# xscreensaver -no-splash &
eval `ssh-agent`
~/projects/scripts/keyup.sh
thunar --daemon &
emacs --daemon &
# mpdscribble &
~/builds/bin/randomfile -p ~/images/wallpapers
xset b off &
setxkbmap -option "ctrl:nocaps" &

DEFAULT_SESSION=stumpwm

case $1 in
stumpwm)
	exec dbus-launch ck-launch-session stumpwm
	;;
twm)
        exec dbus-launch ck-launch-session twm
        ;;
*)
	exec dbus-launch ck-launch-session $DEFAULT_SESSION
	;;
esac
