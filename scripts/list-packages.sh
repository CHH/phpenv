#!/bin/bash

source "$PHPENV_SCRIPTS_DIR/base.sh"

ls $PACKAGE_DIR | sed s/\.tar\.bz2//
