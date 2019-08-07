#!/bin/bash

# We want to see what is executed and fail on bad exit codes
set -ex

source $(dirname $0)/funcs.sh

echo "Preparing image"
cd $PHAROBUILD
cp RoamingHub.image /var/pharo/images/61/RoamingHub.image
cp RoamingHub.changes /var/pharo/images/61/RoamingHub.changes
ln -s /usr/lib/i386-linux-gnu/libcrypto.so.1.0.0 /var/pharo/images/61/libcrypto.so

cat > /startup.sh << __EOF__
#! /bin/bash
export LD_LIBRARY_PATH=/var/pharo/images/61
/usr/bin/start-image /etc/image-launch/images/HLR
__EOF__
chmod 755 /startup.sh
chown root:root /startup.sh
