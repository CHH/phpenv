#!/bin/bash

function usage {
    echo "Displays the current default PHP"
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

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
