#!/usr/bin/env bash

set -e

PHPENV_ROOT="$HOME/.phpenv"

git clone git://github.com/sstephenson/rbenv.git "$PHPENV_ROOT" > /dev/null

cat > "$PHPENV_ROOT/bin/phpenv" <<SH
#!/usr/bin/env bash
export RBENV_ROOT=$PHPENV_ROOT

DIRNAME="\$(dirname \$0)"
RBENV=\$(readlink -f "\$DIRNAME/../libexec/rbenv")

exec "\$RBENV" \$@
SH

chmod +x "$PHPENV_ROOT/bin/phpenv"
