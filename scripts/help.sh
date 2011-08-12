#!/bin/bash

command=$1

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -z "$command" ]; then
    phpenv_fail "No Command given."
fi

if [ ! -f "$PHPENV_SCRIPTS_DIR/$command.sh" ]; then
    phpenv_fail "Command $command not found."
fi

"$PHPENV_SCRIPTS_DIR/$command.sh" --help
