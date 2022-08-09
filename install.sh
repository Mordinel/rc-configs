#!/bin/bash

echo "Your current config files will be deleted and replaced."
read -p "Replace with repo versions? (y/N): " choice

if [[ "$choice" =~ ^[yY] ]]
then
    ln -sf $PWD/bashrc $HOME/.bashrc

    mkdir -p $HOME/.vim
    ln -sf $PWD/vimrc $HOME/.vim/vimrc

    mkdir -p $HOME/.config/tmux
    ln -sf $PWD/tmux.conf $HOME/.config/tmux/tmux.conf

    mkdir -p $HOME/.config/alacritty
    ln -sf $PWD/alacritty.yml $HOME/.config/alacritty/alacritty.yml

    mkdir -p $HOME/.config/gtk-3.0/
    ln -sf $PWD/gtk3.ini $HOME/.config/gtk-3.0/settings.ini

    ln -sf $PWD/herbstluftwm $HOME/.config/herbstluftwm
    ln -sf $PWD/polybar $HOME/.config/polybar
    ln -sf $PWD/rofi $HOME/.config/rofi
    ln -sf $PWD/picom $HOME/.config/picom

    ln -sf $PWD/gtkrc-2.0 $HOME/.gtkrc-2.0
    echo "Config files have been replaced with symlinks to the config files in this git repo."
fi

