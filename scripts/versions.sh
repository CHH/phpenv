#!/bin/bash
#/ Lists all available PHP Versions
#/
#/ Usage: phpenv versions
#/

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit $?
fi

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

packages=$(ls -1 "$PHPENV_ROOT/versions")

for package in $packages
do
    if [ -n "$enabled" ] && [ "$enabled" = "$package" ]; then
        echo "* $package (set by $version_source)"
    else
        echo "  $package"
    fi
done
