#!/bin/sh
# ~/.xinitrc
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
#################################################################################3

sudo loadkeys pl
sudo setfont Lat2-Terminus16
sudo setfont -m 8859-2
sudo localectl set-x11-keymap pl

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
#/usr/bin/xcompmgr -n >/dev/null 2>.i3/xcompmgr_error &

feh --bg-scale /usr/share/wallpapers/Nature-Wallpapers-Beautiful-Sunset.jpg 2>>~/.i3/error
exec i3 >~/.i3/log 2>~/.i3/error
