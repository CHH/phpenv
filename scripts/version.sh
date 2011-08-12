#!/bin/bash

function usage {
    echo "Displays the current default PHP"
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

while [ ! -f "$PWD/.phpenv-default" ]
do
    if [ "$PWD" = "/" ]; then
        break
    fi

    cd ..
done

if [ -f "$PWD/.phpenv-default" ]; then
    echo $(cat "$PWD/.phpenv-default")
    exit 0
fi

if [ -n "$PHPENV_DEFAULT" ]; then
    echo "$PHPENV_DEFAULT"
    exit 0
fi

if [ ! -f "$PHPENV_ROOT/default" ]; then
    echo "No PHP Environment set as default"
    exit 1
fi

package=$(cat "$PHPENV_ROOT/default")

echo "$package"
