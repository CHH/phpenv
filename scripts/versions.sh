#!/bin/bash

function usage {
    echo "Lists all compiled packages. The currently enabled version is marked with a \"*\""
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

version_source=$("$PHPENV_SCRIPTS_DIR/version-source.sh")

if [ 0 -ne $? ]; then
    enabled=
fi

if [ "$version_source" = "PHPENV_VERSION" ]; then
    enabled="$PHPENV_VERSION"
else
    if [ -f "$version_source" ]; then
        enabled=$(cat "$version_source")
    else
        enabled=
    fi
fi

packages=$(ls -1 $TARGET_DIR)

for package in $packages
do
    if [ -n "$enabled" ] && [ "$enabled" = "$package" ]; then
        echo "* $package (set by $version_source)"
    else
        echo "  $package"
    fi
done
