#!/bin/bash

echo "Your current rc files in /home/$USER will be deleted and replaced."
printf "Replace .bashrc and .vimrc with the repo versions? (y/N): "

read choice
choice=$( echo "$choice" | tr '[:upper:]' '[:lower:]' )

if [ $choice == 'y' ] || [ $choice == 'yes' ] 
then
    ln -sf $PWD/bashrc /home/$USER/.bashrc
    ln -sf $PWD/vimrc /home/$USER/.vimrc
fi

