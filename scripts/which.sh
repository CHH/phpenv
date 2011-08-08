#!/bin/bash

function usage {
    echo "Displays the path to the currently activated PHP environment"
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

echo "This is currently not implemented"
