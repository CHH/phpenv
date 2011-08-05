#!/bin/bash
source "$(dirname $0)/base.sh"

ls $PACKAGE_DIR | sed s/\.tar\.bz2//
