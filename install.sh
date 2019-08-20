#!/bin/bash

echo "Your current rc files in $HOME will be deleted and replaced."
printf "Replace .bashrc, .vimrc and .tmux.conf with the repo versions? (y/N): "

read choice
choice=$( echo "$choice" | tr '[:upper:]' '[:lower:]' )

if [[ "$choice" =~ ^[y] ]]
then
    ln -sf $PWD/bashrc $HOME/.bashrc
    ln -sf $PWD/vimrc $HOME/.vimrc
    ln -sf $PWD/tmux.conf $HOME/.tmux.conf
    echo "rc files in $HOME have been replaced with symlinks to the rc files in the git repo."
fi

