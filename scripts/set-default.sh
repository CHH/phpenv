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

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -z $1 ]; then
    usage
    exit
fi

package=$1

if [ "$package" = "system" ]; then
    if [ ! -f "$PHPENV_ROOT/default" ]; then
        exit 1
    fi

    rm "$PHPENV_ROOT/default"
    exit 0
fi

if [ ! -d "$TARGET_DIR/$package" ]; then
    echo "Package $package not found in $TARGET_DIR"
    echo
    usage
    exit -1
fi

echo "$package" > "$PHPENV_ROOT/default"
exit 0
