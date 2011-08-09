#!/bin/bash

function usage {
    echo "Removes a built version"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [package]"
    echo
    echo "Arguments:"
    echo "  package: One of the packages listed with list-versions"
    echo
    echo "These Packages are available:"
    "$PHPENV_SCRIPTS_DIR/list-versions.sh"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -z $1 ]; then
    echo "Package missing."
    usage
    exit 1
fi

if [ ! -d "$PHPENV_ROOT/versions/$1" ]; then
    echo "Package $1 is not a built package."
    exit 1
fi

package=$1

echo "WARNING: All Files in the Package's directory will be lost and *cannot* be restored later"
echo "Do you want to proceed? [Yn]"
read proceed

echo "Removing $package..."

if [ "$proceed" != "Y" ]; then
    echo "Canceled."
    exit 0
fi

rm "$PHPENV_ROOT/versions/$package" -rf

if [ -d "$PHPENV_ROOT/source/$package" ]; then
    rm "$PHPENV_ROOT/source/$package" -rf
fi

echo "Done."
