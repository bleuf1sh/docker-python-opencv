FROM ubuntu:16.04
# Get latest stable opencv
RUN mkdir /tmp/thework
WORKDIR /tmp/thework

ARG BUILD_PACKAGES="build-essential     \
    cmake               \
    git                 \
    gfortran            \
    libatlas-base-dev   \
    libavcodec-dev      \
    libavformat-dev     \
    libjpeg8-dev        \
    libjasper-dev       \
    libpng12-dev        \
    libgtk2.0-dev       \
    libtiff5-dev        \
    libswscale-dev      \
    libv4l-dev          \
    pkg-config          "

RUN apt-get update \
    && apt-get install -y --no-install-recommends $BUILD_PACKAGES \
    && apt-get install -y --no-install-recommends python-pip python2.7-dev \
    && pip install --upgrade pip \
    && pip install numpy scipy
    
ADD temp/opencv-contrib-3.1.0.tar.gz .
ADD temp/opencv-3.1.0.tar.gz .

RUN cd opencv-3.1.0 \
    && mkdir build \
    && cd build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=/tmp/thework/opencv_contrib-3.1.0/modules \
    -D BUILD_EXAMPLES=OFF .. \
    && make -j2 \
    && make install \
    && ldconfig

RUN apt-get remove -y $BUILD_PACKAGES \
    && apt-get -y autoremove  \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/thework/*
 