#!/bin/bash
#/ Displays help for the given command
#/
#/ Usage: phpenv help <command>
#/

command=$1

if [ -z "$command" ]; then
    echo "phpenv: No Command given." >&2
    exit 1
fi

if [ ! -f "$PHPENV_SCRIPTS_DIR/$command.sh" ]; then
    echo "Command \"$command\" not found." >&2
    exit 1
fi

grep '^#/' <"$PHPENV_SCRIPTS_DIR/$command.sh" | cut -c4- >&2
exit 1
