#/bin/bash

function usage {
    echo "Fetches the Tarball for the given release"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [release]"
    echo
    echo "Arguments:"
    echo "  release"
    echo
    echo "Example: phpenv $(basename $0 .sh) php-5.4.0alpha3"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

if [ -z $1 ]; then
    usage
    exit 1
fi

release=$1

function phpenv_download_release {
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
        phpenv_fail "Error while fetching $rel from $uri"
    fi

    cp "$TEMP_DIR/$rel.tar.bz2" "$PACKAGE_DIR/"
    rm "$TEMP_DIR/$rel.tar.bz2"

    echo "Done. You can now build $rel by executing \"phpenv build $rel\""
    exit 0
}

while read name uri
do
    if [ "$name" = "$release" ]; then
        phpenv_download_release $release $uri
    fi
done <"$PHPENV_ROOT/releases"

phpenv_fail "Release $release not found."
