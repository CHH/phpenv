#!/bin/bash

source "$(dirname $0)/base.sh"

# Exit if the package argument is missing
if [ -z $1 ]; then
    echo "Usage: $0 [package]"
    exit
fi

package=$1
package_file="$PACKAGE_DIR/$package.tar.bz2"

if [ ! -f $package_file ]; then
    echo "Package $package not found in $PACKAGE_DIR."
    echo
    echo "These packages are available:"

    $SCRIPTS_DIR/list-packages.sh

    echo
    echo "Drop a PHP Release Tarball called $package.tar.bz2 into the $PACKAGE_DIR to make it available for building."
    exit -1
fi

OUTPUT_DIR="$TARGET_DIR/$package"
mkdir $OUTPUT_DIR

# Extract the tarball if not already extracted
if [ ! -d "$SOURCE_DIR/$package" ]; then
    echo "Extracting $package."
    mkdir "$SOURCE_DIR/$package"
    tar -xj --strip-components 1 -f $package_file -C "$SOURCE_DIR/$package"
    echo "Done."
fi

echo "Preparing Build Process..."
source "$PHPENV_ROOT/bin/configure.sh"

echo "Compiling. This will take a while, so go get some coffee."
cd "$SOURCE_DIR/$package"
make
make install
echo "Done."

echo
echo "What php.ini should be used?"
ini_options="php.ini-development php.ini-production none"
select ini_file in $ini_options; do
    if [ "$ini_file" = "none" ]; then
        break
    fi

    if [ ! -f "$SOURCE_DIR/$package/$ini_file" ]; then
        echo "$ini_file not found in $SOURCE_DIR/$package"
    else
        echo "Using $ini_file"
        cp "$SOURCE_DIR/$package/$ini_file" "$OUTPUT_DIR/etc/php.ini"
    fi
done

echo
echo "Installing Extras"
source "$PHPENV_ROOT/bin/extras/pyrus.sh"

echo "Finished."
exit 0
