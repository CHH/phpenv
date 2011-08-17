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
version_name=$("$PHPENV_SCRIPTS_DIR/version-name.sh")

echo "$version_name (set by $version_source)"
