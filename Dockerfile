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
    pkg-config          \
    python2.7-dev"
# Get all base deps
RUN apt-get update \
    && apt-get install -y $BUILD_PACKAGES \
    && apt-get install -y python-pip      \
    && pip install --upgrade pip \
    && pip install numpy
    
RUN git clone https://github.com/Itseez/opencv_contrib.git \
    && cd opencv_contrib \
    && git checkout 3.1.0 \
    && cd ..
RUN git clone https://github.com/Itseez/opencv.git && cd opencv && git checkout 3.1.0

# build the stuff!
RUN cd opencv && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/tmp/thework/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON .. && make -j2 \ 
    && make install \
    && ldconfig

# Clean up
RUN apt-get remove -y $BUILD_PACKAGES \
    && rm -rf /var/lib/apt/lists/*
    && rm -rf /tmp/thework/* 
 
# TODO Merge it all into one CMD to make the leanest possible docker layer