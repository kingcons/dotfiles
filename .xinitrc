#!/bin/sh
## temporary disabled screensaver due to intel openGL bug *sigh*
# xscreensaver -no-splash &
thunar --daemon &
emacs --daemon &
# mpdscribble &
~/builds/bin/randomfile -p ~/images/wallpapers
xset b off &
setxkbmap -option "ctrl:nocaps" &
eval `ssh-agent`
~/projects/scripts/keyup.sh

DEFAULT_SESSION=stumpwm

case $1 in
stumpwm)
	exec ck-launch-session stumpwm
	;;
twm)
        exec ck-launch-session twm
        ;;
*)
	exec ck-launch-session $DEFAULT_SESSION
	;;
esac
