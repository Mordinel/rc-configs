#!/bin/sh
xsetroot -solid '#000000'
xrdb ~/.Xresources
for n in {0..20};
do
    xinput --set-prop "$n" 'libinput Accel Profile Enabled' 0, 1
done
xset -dpms
setterm -powerdown 0
xset s off
xrandr --output HDMI-1 --primary
