#!/bin/bash
#/ Returns how the PHP Version was set
#/ 
#/ Usage: phpenv version-source
#/
#/ These Sources are considered (in that order):
#/   - PHPENV_VERSION variable
#/   - .phpenv-version file in the current working directory
#/   - The Default set with "phpenv set-default"
#/

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit
fi

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
