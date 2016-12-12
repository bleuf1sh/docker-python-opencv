#!/usr/bin/env bash
# bash strict mode : http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

OPENCV_CORE="opencv-3.1.0.tar.gz"
OPENCV_CONTRIB="opencv-contrib-3.1.0.tar.gz"

if [ ! -d ./temp ]; then
    mkdir ./temp
fi

#gogo
if [ ! -f ./temp/${OPENCV_CORE} ]; then
    echo "opencv core not found, downloading tarball"
    curl -L -o ./temp/${OPENCV_CORE} https://github.com/opencv/opencv/archive/3.1.0.tar.gz 
fi
if [ ! -f ./temp/${OPENCV_CONTRIB} ]; then
    echo "opencv contrib not found"
    curl -L -o ./temp/${OPENCV_CONTRIB} https://github.com/opencv/opencv_contrib/archive/3.1.0.tar.gz  
fi

echo "building docker container"
docker build --squash -t "dbmobilelife/docker-python-opencv"  .