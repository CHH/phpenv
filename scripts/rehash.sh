#!/bin/bash

function usage {
    echo "Traverses versions/*/bin/* and adds wrapper scripts"
    echo "to PHPEnv's PATH, which consider the current default"
    echo
    echo "Usage: phpenv $(basename $0 .sh)"
    echo
}

source "$PHPENV_SCRIPTS_DIR/base.sh"

for file in $TARGET_DIR/*/bin/*
do
    wrapper="$PHPENV_ROOT/bin/$(basename $file)"

    if [ ! -f "$wrapper" ]; then
        echo "#!/bin/bash" > "$wrapper"
        echo 'phpenv exec $(basename $0) $*' >> "$wrapper"
        chmod +x "$wrapper"
    fi
done
