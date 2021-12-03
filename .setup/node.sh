#!/bin/bash

curl -fsSL https://fnm.vercel.app/install | bash

source $HOME/.zshrc
fnm install v16
fnm default v16
fnm use v16

npm i -g yarn typescript rescript eslint react-native-cli create-react-app

