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

    echo "Config files have been replaced with symlinks to the config files in this git repo."
fi

