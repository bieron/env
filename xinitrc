#!/bin/sh
# ~/.xinitrc
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

eval `ssh-agent`
ssh-add

export TZ=`cat /etc/timezone`

sudo loadkeys pl
sudo setfont Ubuntu
sudo setfont -m 8859-2
sudo localectl set-x11-keymap pl

feh --bg-scale /usr/share/wallpapers/bird_persons_big_day.jpg 2>/dev/null
mkdir ~/.i3 2>/dev/null

[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

exec i3 >~/.i3/log 2>~/.i3/error
