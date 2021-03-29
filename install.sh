#!/bin/bash

echo "Your current config files will be deleted and replaced."
read -p "Replace .bashrc, vimrc and tmux.conf with the repo versions? (y/N): " choice

if [[ "$choice" =~ ^[yY] ]]
then
    ln -sf $PWD/bashrc $HOME/.bashrc

    mkdir $HOME/.vim
    ln -sf $PWD/vimrc $HOME/.vim/vimrc

    mkdir $HOME/.config/tmux
    ln -sf $PWD/tmux.conf $HOME/.config/tmux/tmux.conf

    mkdir $HOME/.config/alacritty
    ln -sf $PWD/alacritty.yml $HOME/.config/alacritty/alacritty.yml
    echo "Config files have been replaced with symlinks to the config files in this git repo."
fi

