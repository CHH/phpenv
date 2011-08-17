#!/bin/bash

function usage {
    echo "Sets the project's PHP version"
    echo
    echo "Usage: phpenv $(basename $0 .sh) <version>"
}

E_VERSION_NOTFOUND=127
E_ARGUMENT_MISSING=1

if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    usage
    exit $E_ARGUMENT_MISSING
fi

if [ "$1" = "default" ]; then
    if [ -f "$(pwd)/.phpenv-version" ]; then
        rm "$(pwd)/.phpenv-version"
        exit 0
    else
        echo "No .phpenv-version found in $(pwd)" >&2
        exit $E_VERSION_NOTFOUND
    fi
fi

if [ ! -d "$PHPENV_ROOT/versions/$1" ]; then
    echo "Version $1 not found." >&2
    exit $E_VERSION_NOTFOUND
fi

echo "$1" > "$(pwd)/.phpenv-version"
