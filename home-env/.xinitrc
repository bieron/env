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

sudo -n loadkeys pl
sudo -n setfont Ubuntu -m 8859-2
sudo -n localectl set-x11-keymap pl

bin/fehbg
[ -f .Xresources ] && xrdb .Xresources
eval `ssh-agent`
ssh-add

#which blueman-applet &>/dev/null && blueman-applet &

# rotate i3 logs
#mv .i3/i3.out{,.1} 2>/dev/null
#mv .i3/i3.err{,.1} 2>/dev/null

# set resolution to at most 2560x1600
res=`xrandr --listactivemonitors| grep -Po 'eDP-1 \K\d+'`
if [ $res -ge 2560 ]; then
  xrandr --output eDP-1 --primary --mode 2560x1600 --pos 0x0 --rotate normal # --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
fi

# exec sway -c .i3/config >.i3/sway.out 2>.i3/sway.err
exec i3 -c .i3/config >.i3/out.log 2>.i3/err.log
