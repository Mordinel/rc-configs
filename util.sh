#!/bin/bash

# link with check function symlinks parameter 2 to parameter 1
#   if param 2 does not exist:
#     but it also is a symlink:
#       delete it, the link is broken
#     create the desired symlink
#   if param 2 already exists and is a symlink:
#     do nothing
#   if param 2 already exists and is not a symlink:
#     rm -rf it and create the desired symlink
Install() {
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

