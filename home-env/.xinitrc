#!/bin/sh
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -f "$f" ] && . "$f"
  done
  unset f
fi

export TZ=`cat /etc/timezone`

sudo -n loadkeys pl
sudo -n setfont Ubuntu -m 8859-2
sudo -n localectl set-x11-keymap pl

[ -f .Xresources ] && xrdb .Xresources
eval `ssh-agent`
ssh-add

# rotate i3 logs
#mv .i3/i3.out{,.1} 2>/dev/null
#mv .i3/i3.err{,.1} 2>/dev/null

bin/display
bin/fehbg

type dunst >/dev/null && dunst >.i3/dunst.out.log 2>.i3/dunst.err.log &

# exec sway -c .i3/config >.i3/sway.out 2>.i3/sway.err
exec i3 -c .i3/config >.i3/out.log 2>.i3/err.log
