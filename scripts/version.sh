#!/bin/bash
#/ Displays the version of PHP which is used
#/
#/ Usage: phpenv version
#/

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit $?
fi

version_source=$("$PHPENV_SCRIPTS_DIR/version-source.sh")

if [ 0 -ne $? ]; then
    echo "No Version set." >&2
    exit 1
fi

if [ "$version_source" = "PHPENV_VERSION" ]; then
    version="$PHPENV_VERSION"
else
    if [ -f "$version_source" ]; then
        version=$(cat "$version_source")
    fi
fi

echo "$version (set by $version_source)"
