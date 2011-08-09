#!/bin/bash

echo "Installing the XDebug Extension..."

if [ -d "$TEMP_DIR/xdebug" ] && [ -d "$TEMP_DIR/xdebug/.git" ]; then
    cd "$TEMP_DIR/xdebug"
    git pull origin master
else
    git clone git://github.com/derickr/xdebug.git "$TEMP_DIR/xdebug"
fi

cd "$TEMP_DIR/xdebug"

$OUTPUT_DIR/bin/phpize
$TEMP_DIR/xdebug/configure --enable-xdebug

make
make install

xdebug_ini="$OUTPUT_DIR/etc/conf.d/xdebug.ini"

# Somehow xdebug needs the absolute path to the extensions directory
# to get loaded, so get it from the PHP binary
extensions_dir=$(echo "<?php echo ini_get('extension_dir');" | "$OUTPUT_DIR/bin/php")

if [ ! -f "$xdebug_ini" ]; then
    echo "Installing xdebug.ini"
    echo "zend_extension=\"$extensions_dir/xdebug.so\"" > $xdebug_ini
    echo "html_errors=on" >> $xdebug_ini
fi

echo "Done."
