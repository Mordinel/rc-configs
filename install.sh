#!/bin/bash

echo "Your current config files will be deleted and replaced."
read -p "Replace with repo versions? (y/N): " choice

if [[ "$choice" =~ ^[yY] ]]
then
    # home files
    ln -sf $PWD/bashrc $HOME/.bashrc
    ln -sf $PWD/gtkrc-2.0 $HOME/.gtkrc-2.0

    # home directories
    mkdir -p $HOME/.vim
    ln -sf $PWD/vimrc $HOME/.vim/vimrc

    # ~/.config
    ln -sf $PWD/tmux $HOME/.config/tmux
    ln -sf $PWD/alacritty $HOME/.config/alacritty
    ln -sf $PWD/gtk-3.0 $HOME/.config/gtk-3.0
    ln -sf $PWD/herbstluftwm $HOME/.config/herbstluftwm
    ln -sf $PWD/polybar $HOME/.config/polybar
    ln -sf $PWD/rofi $HOME/.config/rofi
    ln -sf $PWD/picom $HOME/.config/picom

    echo "Config files have been replaced with symlinks to the config files in this git repo."
fi

