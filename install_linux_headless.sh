
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

    # home directories
    mkdir -p $HOME/.vim
    Install $PWD/vimrc $HOME/.vim/vimrc
    mkdir -p $HOME/.scripts
    Install $PWD/scripts $HOME/.scripts

    # ~/.config
    Install $PWD/tmux $HOME/.config/tmux
    Install $PWD/nvim $HOME/.config/nvim

fi

read -p "Run post-install scripts? (y/N): " choice
if [[ "$choice" =~ ^[yY] ]]
then
    # install packer for neovim
    #[[ -e "$PWD/nvim/packer_install.sh" ]] && $PWD/nvim/packer_install.sh
fi

