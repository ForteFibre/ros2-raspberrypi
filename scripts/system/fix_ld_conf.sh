#!/bin/bash

# /etc/ld.so.conf includes using a regex all the files inside ros2-sysroot/etc/ld.so.conf.d
# the regex does not work when cross-compiling, so manually include all the files

if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

ROS2_SYSROOT="$ROS2_CROSS_ROOT/ros2_sysroot"

# clear the file
 > $ROS2_SYSROOT/etc/ld.so.conf

# copy included files
for filename in $ROS2_SYSROOT/etc/ld.so.conf.d/*; do
    #echo "FILE IS: ${filename}"
    cat ${filename} >> $ROS2_SYSROOT/etc/ld.so.conf
done
