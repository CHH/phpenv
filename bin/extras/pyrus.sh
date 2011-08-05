#!/bin/bash

echo Installing Pyrus

wget -P "$OUTPUT_DIR/bin" http://pear2.php.net/pyrus.phar 
mkdir "$OUTPUT_DIR/pear"

echo "include_path=.:$OUTPUT_DIR/pear/php" > "$OUTPUT_DIR/etc/conf.d/pear.ini"

pyrus_sh="$OUTPUT_DIR/bin/pyrus"

echo "#!/bin/bash" > $pyrus_sh
echo "$OUTPUT_DIR/bin/php -dphar.readonly=0 $OUTPUT_DIR/bin/pyrus.phar \$*" > $pyrus_sh

chmod +x "$OUTPUT_DIR/bin/pyrus"

echo Done.
