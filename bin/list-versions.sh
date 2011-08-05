#!/bin/bash

# Load path constants
source "$(dirname $0)/base.sh"

ls -1 --ignore local $TARGET_DIR
