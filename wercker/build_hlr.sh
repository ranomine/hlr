#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Download pharo, then install HLR & dependencies"
mkdir -p $PHAROBUILD && cd $PHAROBUILD
get_pharo
install_hlr
