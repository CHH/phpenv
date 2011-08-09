#!/bin/bash

function usage {
    echo "Fetch a new Tarball and rebuild the Package"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [package]"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -f "$PACKAGE_DIR/$package.tar.bz2" ]; then
    rm "$PACKAGE_DIR/$package.tar.bz2"
fi

"phpenv remove $package" > /dev/null

if [ 1 -eq $? ]; then
    phpenv_fail "Package $package not found"
fi

"phpenv fetch $package"

"phpenv build $package"
