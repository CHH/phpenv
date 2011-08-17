#!/bin/bash

function usage {
    echo "Traverses versions/*/bin/* and adds wrapper scripts"
    echo "to PHPEnv's PATH, which consider the current default"
    echo
    echo "Usage: phpenv $(basename $0 .sh) [options]"
    echo
    echo "Options:"
    echo "  --clean: Removes all executables in PHPEnv's PATH before"
    echo "           creating new ones."
    echo
}

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    usage
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
