#!/bin/bash

function usage {
    echo "Displays the path to the currently activated PHP environment"
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ ! -f "$PHPENV_ROOT/enabled" ]; then
    echo "No PHP Environment set as default"
    exit 1
fi

package=$(cat "$PHPENV_ROOT/enabled")

echo "$TARGET_DIR/$package"
