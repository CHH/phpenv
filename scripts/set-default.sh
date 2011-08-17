#!/bin/bash
#/ Sets the PHP Version as your default
#/
#/ Usage: phpenv set-default <version>
#/
#/ Arguments:
#/     version: A PHP Version in ~/.phpenv/versions
#/

if [ -z $1 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit
fi

version=$1

if [ "$version" = "system" ]; then
    if [ -f "$PHPENV_ROOT/default" ]; then
        rm "$PHPENV_ROOT/default"
    fi
    exit 0
fi

if [ ! -d "$PHPENV_ROOT/versions/$version" ]; then
    echo "phpenv: Version $version not installed."
    exit 1
fi

echo "$version" > "$PHPENV_ROOT/default"
