#!/bin/bash

set -e

function usage {
    echo "Runs the provided executable of the current default version"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [--use <version>] <executable> <arguments,...> [options]"
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
    version_source=$("$PHPENV_SCRIPTS_DIR/version-source.sh")

    if [ 0 -ne $? ]; then
        default=
    fi

    if [ "$version_source" = "PHPENV_VERSION" ]; then
        default="$PHPENV_VERSION"
    else
        if [ -f "$version_source" ]; then
            default=$(cat "$version_source")
        else
            default=
        fi
    fi
fi

realpath="$TARGET_DIR/$default/bin/$command"

if [ ! -x "$realpath" ]; then
    echo "phpenv: Command $command not found"
    exit 1
fi

"$realpath" $@
