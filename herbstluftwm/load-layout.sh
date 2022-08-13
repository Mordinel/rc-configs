#!/bin/bash
SEL=`ls $HOME/.config/herbstluftwm/layouts/ | rofi -dmenu -p "Choose a layout" -i -l 11`
herbstclient load "$(cat $HOME/.config/herbstluftwm/layouts/$SEL)"
