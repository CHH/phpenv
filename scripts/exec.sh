#!/bin/bash

function usage {
    echo "Runs the provided executable of the current default version"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [use <version>] <executable> <arguments,...> [options]"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ "$1" = "--use" ] && [ -n "$2" ]; then
    version=$2
    shift
    shift
fi

command=$1
shift

if [ -n "$version" ] && [ -d "$TARGET_DIR/$version" ]; then
    default="$version"
else
    default=$(phpenv version)
fi

if [ 0 -ne $? ]; then
    exit 1
fi

realpath="$TARGET_DIR/$default/bin/$command"

if [ ! -x "$realpath" ]; then
    echo "phpenv: Command $command not found"
    exit 1
fi

"$realpath" $@
