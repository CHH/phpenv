#!/bin/bash

function usage {
    echo "Lists all downloaded packages"
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

ls $PACKAGE_DIR | sed s/\.tar\.bz2//
