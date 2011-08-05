#!/bin/bash

if [ -z $PHPENV_ROOT ]; then
    PHPENV_ROOT=`readlink -m $(dirname $0)/../`
fi

SCRIPTS_DIR="$PHPENV_ROOT/bin"
PACKAGE_DIR="$PHPENV_ROOT/packages"
SOURCE_DIR="$PHPENV_ROOT/source"
TARGET_DIR="$PHPENV_ROOT/versions"

if [ ! -d $PACKAGE_DIR ]; then
    mkdir $PACKAGE_DIR
fi

if [ ! -d $SOURCE_DIR ]; then
    mkdir $SOURCE_DIR
fi

if [ ! -d $TARGET_DIR ]; then
    mkdir $TARGET_DIR
fi
