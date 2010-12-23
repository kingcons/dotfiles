#!/bin/sh
## temporary disabled screensaver due to intel openGL bug *sigh*
# xscreensaver -no-splash &
thunar --daemon &
emacs --daemon &
# mpdscribble &
~/builds/bin/randomfile -p ~/images/wallpapers
xset b off &
setxkbmap -option "ctrl:nocaps" &

DEFAULT_SESSION=stumpwm

case $1 in
stumpwm)
	exec ck-launch-session ssh-agent stumpwm
	;;
twm)
        exec ck-launch-session twm
        ;;
*)
	exec ck-launch-session ssh-agent $DEFAULT_SESSION
	;;
esac
