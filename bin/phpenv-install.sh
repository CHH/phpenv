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

RBENV_REPO="https://github.com/sstephenson/rbenv.git"

phpenv_script() {
    local root="$1"

    cat <<SH
#!/usr/bin/env bash
export RBENV_ROOT='$root'
exec "\$RBENV_ROOT/libexec/rbenv" "\$@"
SH
}

create_phpenv_bin() {
    local install_location="$1"

    phpenv_script "$install_location" > "$install_location/bin/phpenv"
    chmod +x "$install_location/bin/phpenv"
}

update_phpenv() {
    local install_location="$1"
    local cwd=$(pwd)
    cd "$install_location"

    git pull origin master &> /dev/null

    cd "$cwd"
}

clone_rbenv() {
    local install_location="$1"
    git clone "$RBENV_REPO" "$install_location" > /dev/null
}

if [ -z "$PHPENV_ROOT" ]; then
    PHPENV_ROOT="$HOME/.phpenv"
fi

if [ -z "$CHECKOUT" ]; then
    CHECKOUT=yes
fi

if [ "$UPDATE" = "yes" ]; then
    echo "Updating phpenv in $PHPENV_ROOT"
    update_phpenv "$PHPENV_ROOT"
else
    echo "Installing phpenv in $PHPENV_ROOT"
    if [ "$CHECKOUT" = "yes" ]; then
        clone_rbenv "$PHPENV_ROOT"
        sed -i -e 's/rbenv/phpenv/g' "$PHPENV_ROOT"/completions/rbenv.{bash,zsh}
    fi
fi

create_phpenv_bin "$PHPENV_ROOT"

echo "Success."
echo
echo "export PATH=\"${PHPENV_ROOT}/bin:"'$PATH"'
echo 'eval "$(phpenv init -)"'
echo
echo "Add above line at the end of your ~/.bashrc \
and restart your shell to use phpenv."
echo
