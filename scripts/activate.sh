#!/bin/bash

function usage {
    echo "Sets the given version as default executable for this user"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [package]"
    echo
    echo "Arguments:"
    echo "  package: Name of a built package"
    echo
    echo "These Packages are currently available:"
    $PHPENV_SCRIPTS_DIR/list-versions.sh
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -z $1 ]; then
    usage
    exit
fi

package=$1

if [ ! -d "$TARGET_DIR/$package" ]; then
    echo "Package $package not found in $TARGET_DIR"
    echo
    usage
    exit -1
fi

if [ -h "$TARGET_DIR/local" ]; then
    rm "$TARGET_DIR/local"
fi

echo "Activating $package"
ln -s "$TARGET_DIR/$package" "$TARGET_DIR/local"

if [ 0 -ne $? ]; then
    phpenv_fail "Linking $TARGET_DIR/$package to $TARGET_DIR/local"
    exit -1
fi

echo "Success."
exit 0
