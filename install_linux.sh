#!/bin/bash

if [[ -e "$PWD/util.sh" ]]; then
    source "$PWD/util.sh"
else
    echo "Util script does not exist!"
    exit 1
fi

echo "Your current config files will be deleted and replaced."
read -p "Replace with repo versions? (y/N): " choice

if [[ "$choice" =~ ^[yY] ]]
then
    # home files
    Install $PWD/bashrc $HOME/.bashrc
    Install $PWD/zshrc $HOME/.zshrc
    Install $PWD/gtkrc-2.0 $HOME/.gtkrc-2.0
    Install $PWD/Xresources $HOME/.Xresources
    Install $PWD/Xresources $HOME/.Xdefaults
    Install $PWD/xprofile $HOME/.xprofile

    # home directories
    mkdir -p $HOME/.vim
    Install $PWD/vimrc $HOME/.vim/vimrc
    mkdir -p $HOME/.scripts
    Install $PWD/scripts $HOME/.scripts

    # ~/.config
    Install $PWD/tmux $HOME/.config/tmux
    Install $PWD/alacritty $HOME/.config/alacritty
    Install $PWD/gtk-3.0 $HOME/.config/gtk-3.0
    Install $PWD/i3 $HOME/.config/i3
    Install $PWD/i3status $HOME/.config/i3status
    Install $PWD/i3 $HOME/.config/sway
    Install $PWD/rofi $HOME/.config/rofi
    Install $PWD/picom $HOME/.config/picom
    Install $PWD/nvim $HOME/.config/nvim

fi

read -p "Run post-install scripts? (y/N): " choice
if [[ "$choice" =~ ^[yY] ]]
then
    # install packer for neovim
    [[ -e "$PWD/nvim/packer_install.sh" ]] && $PWD/nvim/packer_install.sh
fi

