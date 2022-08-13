#!/bin/bash
SEL=`rofi -dmenu -p "Enter the name of the new layout"`
herbstclient dump > "$HOME/.config/herbstluftwm/layouts/$SEL"
