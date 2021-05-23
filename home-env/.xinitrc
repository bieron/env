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
sudo setfont Ubuntu -m 8859-2
sudo localectl set-x11-keymap pl

feh --bg-fill `find Pictures/wallpapers/ -type f|shuf -n 1`
[ -f .Xresources ] && xrdb .Xresources
eval `ssh-agent`
ssh-add

# xrandr --output HDMI2 --auto --output eDP1 --auto --left-of HDMI2
exec i3 -c .i3/config >>.i3/out.log 2>>.i3/err.log
