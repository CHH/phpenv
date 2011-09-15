#!/usr/bin/env bash
# The MIT License
#
# Copyright (c) 2011 Christoph Hochstrasser
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

echo "Setting up phpenv in ~/.phpenv"

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

# Disable the rbenv bin in PHPENV_ROOT so it can not take precedence over
# another rbenv installed on the system.
rm "$PHPENV_ROOT/bin/rbenv"

echo "Success."
echo
echo "Now add ~/.phpenv/bin to your \$PATH, add \
\"eval \$(phpenv init -)\" at the end of your ~/.bashrc \
and restart your shell to use phpenv."
echo
