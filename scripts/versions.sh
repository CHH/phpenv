#!/bin/bash

function usage {
    echo "Lists all compiled packages. The currently enabled version is marked with a \"*\""
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

packages=$(ls -1 $TARGET_DIR)
enabled=$(phpenv version)

if [ 0 -ne $? ]; then
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
