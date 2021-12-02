#!/bin/bash

# sudo pacman -Sy aria2 unzip
DISTRO=$(awk -F '=' '/^ID=/ {print tolower($2)}' /etc/*-release)
ANDROID_CMDLINE_V=commandlinetools-linux-7583922_latest.zip
ENV_PATH=.zshrc

if [[ $DISTRO -eq "arch" ]]; then
    sudo pacman -Syu aria2 unzip git base-devel
elif [[ $DISTRO -eq "ubuntu" ]]; then
    sudo apt install build-essentials git aria2 unzip
fi

aria2c -x8 https://dl.google.com/android/repository/$ANDROID_CMDLINE_V
unzip $ANDROID_CMDLINE_V
rm -f $ANDROID_CMDLINE_V

rm -rf $HOME/.android
mkdir -p $HOME/.android/sdk
mv cmdline-tools $HOME/.android/sdk/.
mkdir -p $HOME/.android/sdk/cmdline-tools/tools
mv $HOME/.android/sdk/cmdline-tools/* $HOME/.android/sdk/cmdline-tools/tools/

if grep -q ANDROID_HOME "$HOME/$ENV_PATH"; then
    echo "export ANDROID_HOME=\$HOME/.android/sdk" >> $HOME/$ENV_PATH
    echo "export ANDROID_SDK_ROOT=\$ANDROID_HOME" >> $HOME/$ENV_PATH
    echo "export PATH=\$ANDROID_HOME/platform-tools:\$PATH" >> $HOME/$ENV_PATH
    echo "export PATH=\$ANDROID_HOME/cmdline-tools/tools/bin:\$PATH" >> $HOME/$ENV_PATH
fi
source $HOME/.zshrc
# sdkmanager "platform-tools"
sdkmanager "platforms;android-29" "build-tools;29.0.3"
sdkmanager --licenses
