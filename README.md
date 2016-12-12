# Docker python opencv

This repository contains a Docker base image based off Ubuntu 16.04 with the newest Opencv 3.1 installed from source.

## Building the image

The image should be built with the following command :

```
$ docker build --no-cache -t "dbmobilelife/docker-python-opencv" .
```

Using this tag ensure that you can push to the docker hub

## Notes

Most of the development dependencies are removed to keep the image layer lean, however, python-pip remains installed so inherting containers can install python packages.
 