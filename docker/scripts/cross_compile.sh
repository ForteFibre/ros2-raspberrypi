#!/bin/bash

# clear out everything first
#rm -rf build install log

export TOOLCHAIN_PREFIX=aarch64-linux-gnu
export PYTHONPATH=/root/rootfs/usr/lib/python3.10/site-packages:$PYTHONPATH

export SYSROOT=/root/rootfs
export PYTHON_LIBRARY="${SYSROOT}/usr/lib/aarch64-linux-gnu/libpython3.10.so"
export PYTHON_INCLUDE_DIR="${SYSROOT}/usr/include/python3.10"

if [ -f /root/ros2/install/setup.bash ]; then
    source /root/ros2/install/setup.bash
fi

colcon \
    build \
    --merge-install \
    --cmake-force-configure \
    --cmake-args \
    -DCMAKE_TOOLCHAIN_FILE=/scripts/rpi4_toolchainfile.cmake \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DTHIRDPARTY=ON \
    -DBUILD_TESTING:BOOL=OFF \
    -DPYTHON_SOABI="cpython-310-aarch64-linux-gnu" \
    -DPYTHON_LIBRARY=$PYTHON_LIBRARY \
    -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR \
    "$@"

if [ -d /root/ros2_ws ]; then
    chown -R $UID:$GID /root/ros2_ws
fi