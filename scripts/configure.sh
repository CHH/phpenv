#!/bin/bash

cd "$SOURCE_DIR/$package"

mkdir "$OUTPUT_DIR/etc"
mkdir "$OUTPUT_DIR/etc/conf.d"

./configure \
--without-pear \
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
--prefix=$OUTPUT_DIR \
--with-libdir=lib64
