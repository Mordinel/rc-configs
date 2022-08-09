#!/bin/bash

echo "Your current config files will be deleted and replaced."
read -p "Replace with repo versions? (y/N): " choice

if [[ "$choice" =~ ^[yY] ]]
then
    # home files
    ln -sf $PWD/bashrc $HOME/.bashrc

    # home directories
    mkdir -p $HOME/.vim
    ln -sf $PWD/vimrc $HOME/.vim/vimrc

    # ~/.config
    ln -sf $PWD/tmux $HOME/.config/tmux

    echo "Config files have been replaced with symlinks to the config files in this git repo."
fi

