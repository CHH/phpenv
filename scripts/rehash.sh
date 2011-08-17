#!/bin/bash
#/ Collects executables by all PHP versions and creates
#/ wrapper scripts which proxy to the enabled version
#/
#/ Usage: phpenv rehash [--clean]
#/
#/ Options:
#/     --clean: Removes all proxies before creating new ones.
#/

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    "$PHPENV_SCRIPTS_DIR/help.sh" $0
    exit
fi

if [ "$1" = "--clean" ]; then
    rm "$PHPENV_ROOT/bin/"*
fi

for file in $PHPENV_ROOT/versions/*/bin/*
do
    wrapper="$PHPENV_ROOT/bin/$(basename $file)"

    if [ ! -f "$wrapper" ]; then
        echo "#!/bin/bash" > "$wrapper"
        echo 'phpenv exec $(basename $0) $*' >> "$wrapper"
        chmod +x "$wrapper"
    fi
done
