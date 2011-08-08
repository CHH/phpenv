#!/bin/bash

function usage {
    echo "Disable the currently enabled PHP Version provided by phpenv."
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

echo "Deactivating executables provided by phpenv"

for executable in "$PHPENV_ROOT/bin/"*
do
    if [ -d $executable ]; then
        rm $executable -r
    else
        rm $executable
    fi

    if [ 0 -ne $? ]; then
        phpenv_fail "Failed to disable $executable"
    fi
done

echo Done.
