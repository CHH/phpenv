#!/bin/bash

echo "Installing Pyrus..."

wget -qP "$OUTPUT_DIR/bin" http://pear2.php.net/pyrus.phar 

if [ ! -d "$OUTPUT_DIR/pear" ]; then
    mkdir "$OUTPUT_DIR/pear"
fi

if [ ! -d "$OUTPUT_DIR/share/pear" ]; then
    mkdir -p "$OUTPUT_DIR/share/pear"
fi

echo "include_path=.:$OUTPUT_DIR/pear/php" > "$OUTPUT_DIR/etc/conf.d/pear.ini"

pyrus_sh="$OUTPUT_DIR/bin/pyrus"

echo "#!/bin/bash" > $pyrus_sh
echo "export HOME=$OUTPUT_DIR/share/pear" >> $pyrus_sh
echo "$OUTPUT_DIR/bin/php -dphar.readonly=0 $OUTPUT_DIR/bin/pyrus.phar \$*" >> $pyrus_sh

chmod +x "$OUTPUT_DIR/bin/pyrus"

pearconfig=$(cat <<EOF
<?xml version="1.0"?>
<pearconfig version="1.0">
    <default_channel>pear2.php.net</default_channel>
    <auto_discover>0</auto_discover>
    <http_proxy></http_proxy>
    <cache_dir>$OUTPUT_DIR/pear/cache</cache_dir>
    <temp_dir>$OUTPUT_DIR/pear/temp</temp_dir>
    <verbose>1</verbose>
    <preferred_state>stable</preferred_state>
    <umask>0022</umask>
    <cache_ttl>3600</cache_ttl>
    <my_pear_path>$OUTPUT_DIR/pear</my_pear_path>
    <plugins_dir>$OUTPUT_DIR/share/pear/.pear</plugins_dir>
</pearconfig>
EOF
)

if [ ! -d "$OUTPUT_DIR/share/pear/.pear" ]; then
    mkdir "$OUTPUT_DIR/share/pear/.pear"
fi

pearconfig_file="$OUTPUT_DIR/share/pear/.pear/pearconfig.xml"
echo $pearconfig > "$pearconfig_file"

echo Done.
