#!/bin/sh
# ~/.xinitrc
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -r "$f" ] && . "$f"
  done
  unset f
fi

export TZ=`cat /etc/timezone`

sudo loadkeys pl
sudo setfont Ubuntu
sudo setfont -m 8859-2
sudo localectl set-x11-keymap pl

mkdir .i3 2>/dev/null
feh --bg-fill `find /usr/share/wallpapers/ -type f|shuf -n 1`
[ -f .Xresources ] && xrdb .Xresources
eval `ssh-agent`
ssh-add

exec i3 -c .i3/config >.i3/log 2>.i3/error
