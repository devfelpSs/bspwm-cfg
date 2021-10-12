#!/bin/sh

#--------------------------------# 
#  ╻ ╻╻┏┓╻╻╺┳╸┏━┓┏━╸             #
#  ┏╋┛┃┃┗┫┃ ┃ ┣┳┛┃               #
# ╹╹ ╹╹╹ ╹╹ ╹ ╹┗╸┗━╸             #
# by: devfelps </>               #
# no login manager since forever #
#--------------------------------#

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

##----------------------------------------------------------------------------##
## Launch dbus 
##----------------------------------------------------------------------------##

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

##----------------------------------------------------------------------------##
## Mpd autostart 
##----------------------------------------------------------------------------##
#[ !  -s ~/.config/mpd/pid ] && mpd

##----------------------------------------------------------------------------##
## Update Xresources 
##----------------------------------------------------------------------------##

[[ -f ~/.Xresources ]] && xrdb -merge "${HOME}/.Xresources"

##----------------------------------------------------------------------------##
## My fonts   
##----------------------------------------------------------------------------##

xset +fp /.local/share/fonts
xset +fp /usr/share/fonts
xset fp rehash

##----------------------------------------------------------------------------##
## General settings 
##----------------------------------------------------------------------------##
#start-pulseaudio-x11
picom &
nitrogen --restore &
xsetroot -cursor_name left_ptr
pulseaudio -D

#script para alternar entre 2 monitores
sh monitores.sh
#unclutter &

##----------------------------------------------------------------------------##
## startx
##----------------------------------------------------------------------------##
_start_session() {
  session=${1:-bspwm}
  case $session in
      awesome           ) exec awesome;;
      bspwm             ) exec bspwm;;
      xmonad            ) exec xmonad;;
      dwm               ) exec dwm;;
      bspwm             ) exec bspwm;;
      2bwm              ) exec 2bwm ;;
      i3|i3wm           ) exec i3;;
      mate              ) exec mate-session;;
      openbox           ) exec openbox-session;;
      xfce|xfce4        ) exec startxfce4;;
      # No known session, try to run it as command
      *) exec "$1";;
  esac
}
_start_session "$@"
