#!/bin/bash

cd "$SOURCE_DIR/$package"

if [ ! -d "$OUTPUT_DIR/etc" ]; then
    mkdir "$OUTPUT_DIR/etc"
fi

if [ ! -d "$OUTPUT_DIR/etc/conf.d" ]; then
    mkdir "$OUTPUT_DIR/etc/conf.d"
fi

options="--without-pear \
--with-gd \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--with-vpx-dir=/usr \
--with-freetype-dir=/usr \
--with-t1lib=/usr \
--enable-gd-native-ttf \
--enable-exif \
--with-config-file-path="$OUTPUT_DIR/etc" \
--with-config-file-scan-dir="$OUTPUT_DIR/etc/conf.d" \
--with-mysql=/usr \
--with-zlib \
--with-zlib-dir=/usr \
--with-gettext \
--with-kerberos \
--with-imap-ssl \
--with-mcrypt=/usr \
--with-pdo-mysql=/usr \
--with-pdo-sqlite \
--enable-soap \
--enable-xmlreader \
--with-xsl \
--enable-ftp \
--enable-cgi \
--with-curl=/usr \
--with-tidy \
--with-xmlrpc \
--with-mbstring \
--enable-sysvsem \
--enable-sysvshm \
--enable-shmop \
--with-readline \
--with-mysqli=/usr/bin/mysql_config \
--prefix=$OUTPUT_DIR"

if [ -d "/usr/lib64" ]; then
    options="$options --with-libdir=lib64"
fi

./configure $options

if [ 0 -ne $? ]; then
    phpenv_fail "Error while preparing Build."
    exit 1
fi
