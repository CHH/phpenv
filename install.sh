#!/bin/bash

echo "Installing the PHP Environment Manager"

if [ ! -d "$HOME/.phpenv" ]; then
    git clone git://github.com/CHH/phpenv.git "$HOME/.phpenv"
fi

echo "[[ -f $HOME/.phpenv/scripts/phpenv.sh ]] && source $HOME/.phpenv/scripts/phpenv.sh" >> "$HOME/.bashrc"

echo "Done."
echo
echo "Please restart your interactive shell or \
source ~/.bashrc to start using phpenv."
