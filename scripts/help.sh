#!/bin/bash
#/ Displays help for the given command
#/
#/ Usage: phpenv help <command>
#/

command=$1

if [ -z "$command" ]; then
    phpenv_fail "No Command given."
fi

if [ ! -f "$PHPENV_SCRIPTS_DIR/$command.sh" ]; then
    phpenv_fail "Command \"$command\" not found."
fi

grep '^#/' <"$PHPENV_SCRIPTS_DIR/$command.sh" | cut -c4- >&2
exit 1
