#!/bin/bash

SCRIPTS_DIR="$PHPENV_ROOT/bin"
PACKAGE_DIR="$PHPENV_ROOT/packages"
SOURCE_DIR="$PHPENV_ROOT/source"
TARGET_DIR="$PHPENV_ROOT/versions"
TEMP_DIR="$PHPENV_ROOT/tmp"

# Display the help if -h or --help is given as first argument
if [ "$1" = "--help" ] || [ "$1" == "-h" ]; then
    usage
    exit
fi

function phpenv_fail {
    if [ -z $2 ]; then
        exit_code=1
    else
        exit_code=$2
    fi

    echo "[ERROR] $1"
    exit $exit_code
}
