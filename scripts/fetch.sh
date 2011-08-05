#/bin/bash

source "$PHPENV_SCRIPTS_DIR/base.sh"

function display_usage {
    echo "Usage: $0 [release]"
    echo
    echo "Example: $0 php-5.4.0alpha3"
}

if [ -z $1 ]; then
    display_usage
    exit -1
fi

release=$1

function download {
    local rel=$1
    local uri=$2

    if [ -f $PACKAGE_DIR/$rel.tar.bz2 ]; then
        echo "Tarball for Release $rel already fetched in $PACKAGE_DIR/$rel.tar.bz2."
        exit 1
    fi

    echo "Fetching Release Tarball for $rel from $uri"

    wget -qP $TEMP_DIR $uri

    if [ 0 -ne $? ]; then
        echo
        echo "Error while fetching $rel from $uri"
        exit 1
    fi

    cp "$TEMP_DIR/$rel.tar.bz2" "$PACKAGE_DIR/"
    rm "$TEMP_DIR/$rel.tar.bz2"

    echo "Done."
    exit 0
}

while read name uri
do
    if [ "$name" = "$release" ]; then
        download $release $uri
    fi
done <"$PHPENV_ROOT/releases"

echo "Release $release not found."
