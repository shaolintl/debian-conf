#!/bin/sh
# Script to configure X, start common apps, and start xmonad.
# Author: Vic Fryzel
# http://github.com/vicfryzel/xmonad-config


# Configure PATH so that we can access our scripts below
PATH=$PATH:~/.cabal/bin:~/.xmonad/bin

# Configure X
xsetroot -cursor_name left_ptr &
xrdb -merge ~/.Xdefaults &
setxkbmap -option "ctrl:nocaps" &

# Start a window compositor. This ensures Google Chrome paints correctly.
xcompmgr -n &

# Start the system tray
stalonetray --dockapp-mode simple &

# Start screensaver
xscreensaver -no-splash &

nm-applet &
twmnd &

# Start sound server
pulseaudio --start --log-target=syslog &

LC_CTYPE=en_IN.utf8

exec xmonad
