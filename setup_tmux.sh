#!/bin/bash

git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
ln -s -f $HOME/.tmux/.tmux.conf
cp $HOME/.tmux/.tmux.conf.local $HOME

if ! grep -q autostart_tmux "$HOME/.zshrc"; then
echo "# attact/autostart_tmux" >> $HOME/.zshrc
echo """
if [ -z "\$TMUX" ] && [ \${UID} != 0 ]; then
    tmux new-session -A -s main
fi
""" >> $HOME/.zshrc
fi
