#!/bin/bash

echo "Your current config files will be deleted and replaced."
read -p "Replace with repo versions? (y/N): " choice

# link with check function symlinks parameter 2 to parameter 1
#   if param 2 does not exist:
#     but it also is a symlink:
#       delete it, the link is broken
#     create the desired symlink
#   if param 2 already exists and is a symlink:
#     do nothing
#   if param 2 already exists and is not a symlink:
#     rm -rf it and create the desired symlink
link_chk() {
    if [[ -e "$2" ]]; then
        if [[ -L "$2" ]]; then
            echo "$2 is already a symlink"
        else
            echo "Deleting $2"
            rm -rf "$2"
            echo "Linking $2 -> $1"
            ln -sf "$1" "$2"
        fi
    else
        if [[ -L "$2" ]]; then
            echo "$2 is a broken link, removing it"
            unlink "$2"
        fi
        echo "Linking $2 -> $1"
        ln -sf "$1" "$2"
    fi
}

if [[ "$choice" =~ ^[yY] ]]
then
    # home files
    link_chk $PWD/bashrc $HOME/.bashrc

    # home directories
    mkdir -p $HOME/.vim
    link_chk $PWD/vimrc $HOME/.vim/vimrc

    # ~/.config
    link_chk $PWD/tmux $HOME/.config/tmux

    echo "Config files have been replaced with symlinks to the config files in this git repo."
fi

