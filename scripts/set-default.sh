#!/bin/bash

function usage {
    echo "Sets the given version as default executable for this user"
    echo
    echo "Usage: phpenv $(basename $0 .sh) <package>"
    echo
    echo "Arguments:"
    echo "  package: Name of a built package"
    echo
    echo "These Packages are currently available:"
    $PHPENV_SCRIPTS_DIR/versions.sh
    echo
}

if [ -z $1 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    usage
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
