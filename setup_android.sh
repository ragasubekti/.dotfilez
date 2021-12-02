#!/bin/bash

ANDROID_CMDLINE_V=commandlinetools-linux-7583922_latest.zip
ENV_PATH=.zshrc

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
