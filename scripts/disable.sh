#!/bin/bash

function usage {
    echo "Disable the currently enabled PHP Version provided by phpenv."
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

echo "Deactivating executables provided by phpenv"

executables="php php-config phpize pyrus php-cgi phar"
for executable in $executables
do
    rm "$PHPENV_ROOT/bin/$executable"

    if [ 0 -ne $? ]; then
        phpenv_fail "Failed to disable $executable"
    fi
done

if [ -f "$PHPENV_ROOT/default" ]; then
    rm "$PHPENV_ROOT/default"
fi

if [ -d "$PHPENV_ROOT/bin/pear" ]; then
    rm -r "$PHPENV_ROOT/bin/pear"
else
    rm "$PHPENV_ROOT/bin/pear"
fi

echo Done.
