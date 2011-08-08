#!/bin/bash

export PHPENV_ROOT=$HOME/.phpenv
export PHPENV_SCRIPTS_DIR=$PHPENV_ROOT/scripts

if [ ! -d "$PHPENV_ROOT/bin/pear" ] && [ ! -h "$PHPENV_ROOT/bin/pear" ]; then
    mkdir "$PHPENV_ROOT/bin/pear"
fi

export PATH="$PHPENV_ROOT/bin:\
$PHPENV_ROOT/bin/pear:\
$PATH"

function phpenv_usage {
    echo "Usage: phpenv [command]"
    echo
    echo "Available Commands:"
    echo "fetch build activate list-packages list-versions remove which"
    echo
}

function phpenv {
    if [ -z $1 ]; then
        phpenv_usage
        return 1
    fi

    if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo "0.1.0alpha1"
        return 0
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        phpenv_usage
        return 0
    fi

    if [ ! -f "$PHPENV_SCRIPTS_DIR/$1.sh" ]; then
        echo "Command $1 not found."
        echo
        phpenv_usage
        return 1
    fi

    command=$1
    shift

    "$PHPENV_SCRIPTS_DIR/$command.sh" $@
    return $?
}
