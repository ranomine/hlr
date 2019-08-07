#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Install apt-get dependencies"
apt-get clean
apt-get update
apt-get install -y \
    libssl1.0.0:i386 \
    libbotan1.10-dev \
    pkg-config \
    curl
rm -rf /var/lib/apt/lists/*

echo "Running latency bench"
make -C $BASEDIR/latency

echo "Loading profiler"
$HUB eval --save "'$BASEDIR/RoamingHubSystemProfiler.st' asFileReference fileIn"
