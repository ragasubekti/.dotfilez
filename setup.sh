#!/bin/bash

DISTRO=$(awk -F '=' '/^ID=/ {print tolower($2)}' /etc/*-release)

if [[ $DISTRO -eq "arch" ]]; then
    sudo pacman -Syu aria2 unzip git base-devel zsh tmux curl
elif [[ $DISTRO -eq "ubuntu" ]]; then
    sudo apt install build-essentials git aria2 unzip zsh tmux curl
fi

zsh -c .setup/zsh.sh
zsh -c .setup/android.sh
zsh -c .setup/node.sh
zsh -c .setup/tmux.sh
zsh -c .setup/flutter.sh
