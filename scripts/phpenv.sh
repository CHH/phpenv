#!/bin/bash

export PHPENV_ROOT=$HOME/.phpenv
export PHPENV_SCRIPTS_DIR=$PHPENV_ROOT/scripts

export PATH="$PHPENV_ROOT/bin:$PATH"

function phpenv_usage {
    echo "Usage: phpenv <command>"
    echo
    echo "Available Commands:"
    echo "fetch build set-default disable packages version versions remove exec"
    echo
    echo "Type \"phpenv help <command>\" to get help for a command."
    echo
}

function phpenv {
    if [ -z $1 ]; then
        phpenv_usage
        return 1
    fi

    if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo $(cat "$PHPENV_ROOT/VERSION")
        return 0
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        phpenv_usage
        return 0
    fi

    if [ "$1" = "base" ]; then
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

    if [ "$command" = "rehash" ]; then
        hash -r
    fi

    return $?
}

export -f phpenv
