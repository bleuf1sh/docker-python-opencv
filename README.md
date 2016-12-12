# Docker python opencv

This repository contains a Docker base image based off Ubuntu 16.04 with the newest Opencv 3.1 installed from source.

## Building and pushing the image

Ensure that you have the following local dependencies installed:
 - `curl`
 - Docker version 1.13 RC3 or newer (as the new `--squash` flag is used)


Then Use the bundled `build.sh` script.

```
$ ./build.sh
```

ON MASTER when the build is good, you can publish to dockerhub
```
$ docker push dbmobilelife/docker-python-opencv
```

If you get authentication problems, ensure that you are logged in

```
$ docker login
```

## Notes

Most of the development dependencies are removed to keep the image layer lean, however, python-pip remains installed so inherting containers can install python packages.
 