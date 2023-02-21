#!/bin/bash

if [ ! -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

cat ros2-cross.tgz | gunzip -c - | docker import - rpi4_cross_compile


if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot ]; then
 tar -zxf ros2-sysroot.tgz -C ros2_sysroot etc lib opt usr
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_humble ]; then
 tar -zxf ros2-humble-prebuild.tgz -C ros2_humble etc lib opt usr
fi
