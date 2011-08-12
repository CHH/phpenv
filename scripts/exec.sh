#!/bin/bash

function usage {
    echo "Runs the provided executable of the current default version"
    echo
    echo "Usage: phpenv $(basename $0 .sh) <executable> <arguments,...> [options]"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

command=$1
shift

default=$(phpenv version)

if [ 0 -ne $? ]; then
    exit 1
fi

realpath="$TARGET_DIR/$default/bin/$command"

if [ ! -x "$realpath" ]; then
    echo "phpenv: Command $command not found"
    exit 1
fi

"$realpath" $@
