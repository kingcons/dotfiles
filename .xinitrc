#!/bin/sh
xscreensaver -no-splash &
thunar --daemon &
# mpdscribble &
~/builds/bin/randomfile -p ~/images/wallpapers
xset -b &
setxkbmap -option "ctrl:nocaps" &

DEFAULT_SESSION=stumpwm

case $1 in
stumpwm)
	exec ck-launch-session ssh-agent stumpwm
	;;
twm)
        exec ck-launch-session ssh-agent twm
        ;;
*)
	exec ck-launch-session ssh-agent $DEFAULT_SESSION
	;;
esac
