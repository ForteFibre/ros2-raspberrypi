#!/bin/bash

# clear out everything first
#rm -rf build install log

export TOOLCHAIN_PREFIX=aarch64-linux-gnu

if [ -f /opt/ros/humble/setup.bash ]; then
  source /opt/ros/humble/setup.bash
fi

colcon \
    build \
    --merge-install \
    --cmake-force-configure \
    --cmake-args \
    -DCMAKE_TOOLCHAIN_FILE=`pwd`/rpi4_toolchainfile.cmake \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DTHIRDPARTY=ON \
    -DBUILD_TESTING:BOOL=OFF \
    -DPYTHON_SOABI="cpython-310-aarch64-linux-gnu"

