#!/bin/bash
#/

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

if [ -z "$version" ]; then
    echo "phpenv: No Version is set." >&2
    exit 1
fi

echo "$version"
