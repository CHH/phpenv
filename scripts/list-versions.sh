#!/bin/bash

# Load path constants
source "$PHPENV_SCRIPTS_DIR/base.sh"

packages=$(ls -1 --ignore local $TARGET_DIR)

if [ -f "$PHPENV_ROOT/enabled" ]; then
    enabled=$(cat "$PHPENV_ROOT/enabled")
else
    enabled=
fi

for package in $packages
do
    if [ -n "$enabled" ] && [ "$enabled" = "$package" ]; then
        echo "* $package"
    else
        echo "  $package"
    fi
done
