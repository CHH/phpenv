#!/bin/bash

export PHPENV_ROOT=$HOME/.phpenv
export PHPENV_SCRIPTS_DIR=$PHPENV_ROOT/scripts
export PATH="$PHPENV_ROOT/bin:$PATH"

function _phpenv_usage {
    echo "Usage: phpenv <command> [options]"
    echo
    echo "Available Commands:"
    
    for cmd in "$PHPENV_SCRIPTS_DIR/"*.sh
    do
        if [ "$(basename $cmd)" = "base.sh" ] || [ "$(basename $cmd)" = "phpenv.sh" ]; then
            continue
        fi
        echo -n "$(basename $cmd .sh) "
    done

    echo
    echo
    echo "Type \"phpenv help <command>\" to get help for a command."
    echo
}

function phpenv_fail {
    if [ -z $2 ]; then
        exit_code=1
    else
        exit_code=$2
    fi

    echo "phpenv: [ERROR] $1" >&2
    exit $exit_code
}
export -f phpenv_fail

function phpenv {
    if [ -z $1 ]; then
        _phpenv_usage
        return 1
    fi

    if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo $(cat "$PHPENV_ROOT/VERSION")
        return 0
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        _phpenv_usage
        return 0
    fi

    if [ "$1" = "base" ]; then
        _phpenv_usage
        return 0
    fi

    if [ ! -f "$PHPENV_SCRIPTS_DIR/$1.sh" ]; then
        echo "Command $1 not found."
        echo
        _phpenv_usage
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

phpenv rehash

