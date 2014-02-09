#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# sony-acpid
(/home/nycholas/bin/sony-acpid &)

# keybindings 
(xbindkeys &)

# xscreensaver
(xscreensaver -nosplash &)

# beep
(/usr/bin/xset b off)

# Java apps are broken and need a WM on their hardcoded list. For maximum
# irony, you should impersonate LG3D, a window manager written by Sun in Java.
# Available from http://tools.suckless.org/wmname
wmname LG3D

# FVWM
#exec ck-launch-session dbus-launch fvwm

# FVWM-Crystal
#exec ck-launch-session dbus-launch fvwm-crystal

# NOTION3
#(trayion &)
#(autocutsel -fork &)
#(autocutsel -selection PRIMARY -fork &)
#exec ck-launch-session dbus-launch notion

# Qtile
#exec ck-launch-session dbus-launch qtile

# i3
exec ck-launch-session dbus-launch i3
#exec ck-launch-session dbus-launch i3 -V >>~/.i3/i3log 2>&1
#exec ck-launch-session dbus-launch i3 --force-xinerama -V >>~/.i3/i3log 2>&1
