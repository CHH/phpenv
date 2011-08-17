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

package=$1

if [ "$package" = "system" ]; then
    if [ -f "$PHPENV_ROOT/default" ]; then
        rm "$PHPENV_ROOT/default"
    fi
    exit 0
fi

if [ ! -d "$PHPENV_ROOT/versions/$package" ]; then
    echo "Package $package not found in $TARGET_DIR"
    echo
    usage
    exit -1
fi

echo "$package" > "$PHPENV_ROOT/default"
exit 0
