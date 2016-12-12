# Docker python opencv

This repository contains a Docker base image based off Ubuntu 16.04 with the newest Opencv 3.1 installed from source.

## Building the image

Use the bundled `build.sh` script. You need to have the following installed on your machine:
 - `curl`
 - Docker version 1.13 RC3 or newer (as the new `--squash` flag is used)
 
## Notes

Most of the development dependencies are removed to keep the image layer lean, however, python-pip remains installed so inherting containers can install python packages.
 