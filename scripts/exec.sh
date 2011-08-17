#!/bin/bash
#/ Runs the given executable
#/
#/ Usage: phpenv exec [--use ...] <executable> <arguments>,... [options]
#/

set -e

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit
fi

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

realpath="$PHPENV_ROOT/versions/$default/bin/$command"

if [ ! -x "$realpath" ]; then
    echo "phpenv: Command \"$command\" not found." >&2
    exit 127
fi

"$realpath" $@
