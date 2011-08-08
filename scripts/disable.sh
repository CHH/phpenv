#!/bin/bash

function usage {
    echo "Disable the currently enabled PHP Version provided by phpenv."
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

for executable in "$PHPENV_ROOT/bin/*"
do
    echo "Disabling $executable"
done
