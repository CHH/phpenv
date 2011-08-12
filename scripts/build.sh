#!/bin/bash

function usage {
    echo "Build a given PHP version"
    echo
    echo "Usage: phpenv $(basename $0 .sh) <package>"
    echo 
    echo "Arguments:"
    echo "  package: The package name as output by list-packages"
    echo
    echo "Options:"
    echo "  --help|-h Display this Message"
    echo
    echo "These Packages are available:"
    $PHPENV_SCRIPTS_DIR/packages.sh
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ ! -e "/usr/bin/make" ]; then
    phpenv_fail "It seems that \"make\" is not installed. Please install it."
fi

# Exit if the package argument is missing
if [ -z $1 ]; then
    usage
    exit
fi

package=$1
package_file="$PACKAGE_DIR/$package.tar.bz2"

if [ ! -f $package_file ]; then
    echo "Package $package not found in $PACKAGE_DIR."
    echo
    echo "These packages are available:"

    $SCRIPTS_DIR/packages.sh

    echo
    echo "Drop a PHP Release Tarball called $package.tar.bz2 into the $PACKAGE_DIR to make it available for building."
    exit 1
fi

OUTPUT_DIR="$TARGET_DIR/$package"
[[ ! -d $OUTPUT_DIR ]] && mkdir $OUTPUT_DIR

# Extract the tarball if not already extracted
if [ ! -d "$SOURCE_DIR/$package" ]; then
    echo "Extracting $package..."
    mkdir "$SOURCE_DIR/$package"

    # The Archive contains at the root level a folder named after the 
    # PHP Version or Build date of the PHP Version. Therefore its not
    # so easily predictable and so we strip it off.
    tar -xj --strip-components 1 -f $package_file -C "$SOURCE_DIR/$package"
    echo "Done."
    echo
fi

echo "Preparing Build Process..."
source "$PHPENV_SCRIPTS_DIR/build/configure.sh"
echo "Done."

echo
echo "Compiling. This will take a while. Get some coffee."
cd "$SOURCE_DIR/$package"
make > /dev/null
make install > /dev/null

if [ 0 -ne $? ]; then
    phpenv_fail "Error in Build Process. Aborting."
fi

echo "Done."

echo
echo "What php.ini should be used?"
ini_options="php.ini-development php.ini-production none"
select ini_file in $ini_options; do
    if [ "$ini_file" = "none" ]; then
        break
    fi

    if [ -f "$SOURCE_DIR/$package/$ini_file" ]; then
        echo "Using $ini_file as php.ini"
        cp "$SOURCE_DIR/$package/$ini_file" "$OUTPUT_DIR/etc/php.ini"
    else
        echo "$ini_file not found in $SOURCE_DIR/$package"
    fi
    break
done

echo
echo "Installing Extras"
echo

for extra in "$PHPENV_SCRIPTS_DIR/build_extras/"*.sh
do
    source $extra
done

echo "Finished building $package."
exit 0
