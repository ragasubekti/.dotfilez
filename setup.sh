#!/bin/bash

DISTRO=$(awk -F '=' '/^ID=/ {print tolower($2)}' /etc/*-release)

if [[ $DISTRO -eq "arch" ]]; then
    sudo pacman -Syu aria2 unzip git base-devel zsh tmux curl
elif [[ $DISTRO -eq "ubuntu" ]]; then
    sudo apt install build-essentials git aria2 unzip zsh tmux curl
fi

zsh -c ./setup_zsh.sh
bash -c ./setup_android.sh
bash -c ./setup_node.sh
bash -c ./setup_tmux.sh
