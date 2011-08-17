#!/bin/bash
#/ Lists all available PHP Versions
#/
#/ Usage: phpenv versions
#/

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit $?
fi

enabled=$("$PHPENV_SCRIPTS_DIR/version-name.sh")
version_source=$("$PHPENV_SCRIPTS_DIR/version-source.sh")

versions=$(ls -1 "$PHPENV_ROOT/versions")

for version in $versions
do
    if [ -n "$enabled" ] && [ "$enabled" = "$version" ]; then
        echo "* $version (set by $version_source)"
    else
        echo "  $version"
    fi
done
