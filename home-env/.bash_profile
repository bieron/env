if [ -z "$DISPLAY" -a `tty` = /dev/tty1 ]; then exec startx; fi
