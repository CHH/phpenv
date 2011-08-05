#!/bin/bash

source "$(dirname $0)/base.sh"

function display_usage {
    echo "Usage: $0 [package]"
}

if [ -z $1 ]; then
    display_usage
    exit
fi

package=$1

if [ ! -d "$TARGET_DIR/$package" ]; then
    echo "Package $package not found in $TARGET_DIR"
    echo
    echo "These Versions are available:"

    $SCRIPTS_DIR/list-versions.sh
    echo
    echo "Call \"build.sh $package\" to make it available."
    exit -1
fi

if [ -h "$TARGET_DIR/local" ]; then
    rm "$TARGET_DIR/local"
fi

echo "Activating $package"
ln -s "$TARGET_DIR/$package" "$TARGET_DIR/local"

if [ 0 -ne $? ]; then
    echo "[FAILURE]: Linking $TARGET_DIR/$package to $TARGET_DIR/local"
    exit -1
fi

echo "Success."
exit 0
