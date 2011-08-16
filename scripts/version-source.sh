#!/bin/bash

function usage {
    echo "Returns the Source for version information"
    echo
    echo "These Sources are considered (in that order):"
    echo "  - PHPENV_VERSION variable"
    echo "  - .phpenv-version file in the current working directory"
    echo "  - The Default set with \"phpenv set-default\""
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -n "$PHPENV_VERSION" ]; then
    echo "PHPENV_VERSION"
    exit 0
fi

# Look up the next .phpenv-version file

while [ ! -f "$(pwd)/.phpenv-version" ]
do
    if [ "$(pwd)" = "/" ]; then
        break
    fi

    cd ..
done

if [ -f "$(pwd)/.phpenv-version" ]; then
    echo "$(pwd)/.phpenv-version"
    exit 0
fi

if [ -f "$PHPENV_ROOT/default" ]; then
    echo "$PHPENV_ROOT/default"
    exit 0
fi

echo "No Version set" >&2
exit 1
