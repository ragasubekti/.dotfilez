#!/bin/bash

URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.5.3-stable.tar.xz

aria2c -x8 $URL

tar xvf flutter*.tar.xz
rm -f flutter*.tar.xz
mv flutter $HOME/.flutter
if ! grep -q "flutter_setup" "$HOME/.zshrc"; then
echo """
# flutter_setup
export FLUTTER_PATH=\"\$HOME/.flutter\"
export PATH=\"\$FLUTTER_PATH/bin:\$PATH\"
""" >> $HOME/.zshrc
fi

source $HOME/.zshrc
flutter doctor
yes | flutter doctor --android-licenses
