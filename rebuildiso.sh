#!/bin/sh
DIR=$(pwd)
rm $DIR/tmp -rv
build-simple-cdd --conf sda.media.conf --debian-mirror http://localhost:9999/debian/ --logfile buildlog$(date +%F_%H-%M-%p).log
