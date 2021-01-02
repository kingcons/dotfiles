#!/bin/sh

GUIX_USER_PROFILES=$HOME/.guix-user-profiles

for i in $GUIX_USER_PROFILES/*; do
    profile=$i
    if [ -f "$profile"/etc/profile ]; then
        GUIX_PROFILE="$profile"
        . "$GUIX_PROFILE"/etc/profile
    fi
    unset profile
done

emacs --daemon

exec ssh-agent stumpwm "$@"
