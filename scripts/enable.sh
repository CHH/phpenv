#!/bin/bash

function usage {
    echo "Sets the given version as default executable for this user"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [package]"
    echo
    echo "Arguments:"
    echo "  package: Name of a built package"
    echo
    echo "These Packages are currently available:"
    $PHPENV_SCRIPTS_DIR/list-versions.sh
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -z $1 ]; then
    usage
    exit
fi

package=$1

if [ ! -d "$TARGET_DIR/$package" ]; then
    echo "Package $package not found in $TARGET_DIR"
    echo
    usage
    exit -1
fi

function activate_bin {
    file=$1
    target="$PHPENV_ROOT/bin/$(basename $1)"

    if [ ! -f "$file" ]; then
        return 1
    fi

    if [ -h "$target" ]; then
        rm $target
    fi
    ln -s $file $target

    return $?
}

executables="php php-config phpize pyrus php-cgi phar"

for executable in $executables
do
    echo "Activating $executable of $package"
    activate_bin "$TARGET_DIR/$package/bin/$executable"

    if [ 0 -ne $? ]; then
        phpenv_fail "Activation of $executable failed"
    fi
done

# Activate Binaries provided by PEAR Packages
echo
echo "Enabling Executables provided by PEAR Packages..."

if [ -h "$PHPENV_ROOT/bin/pear" ]; then
    rm "$PHPENV_ROOT/bin/pear" -r
fi

ln -s "$TARGET_DIR/$package/pear/bin" "$PHPENV_ROOT/bin/pear"

echo "Done."
echo
echo "$package successfully enabled." 
echo
echo "Your Default PHP Versions is now:"
echo $(php -v)
echo
exit 0
