#!/bin/sh
xrdb ~/.Xresources
xinput --set-prop 13 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 14 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 15 'libinput Accel Profile Enabled' 0, 1
xset -dpms
setterm -powerdown 0
xset s off
