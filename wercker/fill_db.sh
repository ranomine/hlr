#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Starting db"
start_standalone_mongo

echo "Fill db"
cd $PHAROBUILD
python -B $BASEDIR/tests/fill_db.py --pharo-vm=$PHAROVM $PHAROTEST $REPLSET --threads=6
