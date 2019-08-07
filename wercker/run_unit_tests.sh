#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Running unit tests"
cd $PHAROBUILD
$HUB test --junit-xml-output "RoamingHub" "RoamingHub-Events" "RoamingHub-KR-REST"
