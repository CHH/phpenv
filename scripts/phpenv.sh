#!/bin/bash

export PHPENV_ROOT=$HOME/.phpenv
export PHPENV_SCRIPTS_DIR=$PHPENV_ROOT/scripts

export PATH="$PHPENV_ROOT/bin:\
$PHPENV_ROOT/bin/pear:\
$PATH"
