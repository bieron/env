#!/bin/sh
# ~/.xinitrc
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -f "$f" ] && . "$f"
  done
  unset f
fi

export TZ=`cat /etc/timezone`

sudo loadkeys pl
sudo setfont Ubuntu -m 8859-2
sudo localectl set-x11-keymap pl

bin/fehbg
[ -f .Xresources ] && xrdb .Xresources
eval `ssh-agent`
ssh-add

which blueman-applet &>/dev/null && blueman-applet &

# rotate i3 logs
mv .i3/i3.out{,.1} 2>/dev/null
mv .i3/i3.err{,.1} 2>/dev/null

# exec sway -c .i3/config >.i3/sway.out 2>.i3/sway.err
exec i3 -c .i3/config >.i3/i3.out 2>.i3/i3.err
