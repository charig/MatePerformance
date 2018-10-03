#!/bin/bash
set -e # make script fail on first error

SCRIPT_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
if [ ! -d $SCRIPT_PATH ]; then
    echo "Could not determine absolute dir of $0"
    echo "Maybe accessed with symlink"
fi

BASE_DIR="$SCRIPT_PATH"

source "$BASE_DIR/config.inc"
source "$BUILDSCRIPTS_DIR/basicFunctions.inc"

## Check for requirements
check_for_tools git ant make mv uname cc c++
check_for_node  "non-fatal"
check_for_pypy  "non-fatal"

## Install the different implementations
$BUILDSCRIPTS_DIR/build-mate.sh "EnvironmentInShape" "master" "metaobjectInShape"
#$BUILDSCRIPTS/build-mate.sh "EnvironmentInObject" "environmentInObject" "metaobjectInObject"
$BUILDSCRIPTS/build-pharo.sh
$BUILDSCRIPTS/build-benchmarks.sh
