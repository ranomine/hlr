#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Starting mongodb with replica set"
start_replica_set_mongo

echo "Running integration tests"
cd $PHAROBUILD
$HUB test --junit-xml-output "RoamingHub-SystemTests"
REPLSET="--repl-set=ciTest"
python -B $BASEDIR/tests/system_test.py --pharo-vm=$PHAROVM $PHAROTEST $REPLSET
python -B $BASEDIR/tests/smoke_test.py --pharo-vm=$PHAROVM $PHAROTEST $REPLSET
python -B $BASEDIR/tests/event_test.py --pharo-vm=$PHAROVM $PHAROTEST $REPLSET

