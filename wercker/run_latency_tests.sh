#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Running latency tests"
cd $PHAROBUILD
$BASEDIR/latency/run.py \
    --pharo-vm=$PHAROVM $PHAROTEST $REPLSET \
    --warmup-args="-m 100 -p 5003 -r 1 -i 10" \
    --profile-args="-m 1000 -p 5003 -r 5 -i 10"
# to profile with overload: "-m 1000 -p 5003 -r 5 -i 10"

echo "Report created"
head profile_report.txt