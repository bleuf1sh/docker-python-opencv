FROM ubuntu:16.04
# Get latest stable opencv
RUN mkdir /tmp/thework
WORKDIR /tmp/thework

ARG BUILD_PACKAGES="build-essential     \
    cmake               \
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

# Extra build packages installed automatically that we wish to remove
ARG EXTRA_BUILD_PACKAGES="binutils bzip2 cmake-data cpp cpp-5 dpkg-dev \
g++ g++-5 gcc gcc-5 gfortran-5 git-man libavutil-dev libgcc-5-dev libgfortran-5-dev \
libharfbuzz-dev libice-dev libjbig-dev libjpeg-turbo8-dev liblzma-dev libpcre3-dev libpixman-1-dev \
libpthread-stubs0-dev libsm-dev libstdc++-5-dev libswresample-dev  libx11-dev libxau-dev \
libxcb-render0-dev libxcb-shm0-dev libxcb1-dev libxcomposite-dev libxcursor-dev libxdamage-dev \
libxdmcp-dev libxext-dev libxfixes-dev libxi-dev libxinerama-dev libxrandr-dev libxrender-dev \
make patch x11proto-composite-dev x11proto-core-dev x11proto-damage-dev x11proto-fixes-dev \
x11proto-input-dev x11proto-kb-dev x11proto-randr-dev x11proto-render-dev x11proto-xext-dev \
x11proto-xinerama-dev xtrans-dev zlib1g-dev"

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

RUN apt-get purge -y $BUILD_PACKAGES $EXTRA_BUILD_PACKAGES \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/thework/*
 
RUN ln -s /usr/local/lib/python2.7/site-packages/cv2.so /usr/lib/cv2.so