#!/bin/bash

if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

touch "$ROS2_CROSS_ROOT/.PREBUILT"

cat $ROS2_CROSS_ROOT/ros2-cross.tgz | gunzip -c - | docker import - ros2_arm64_cross

if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot ]; then
 tar -zxf $ROS2_CROSS_ROOT/ros2-sysroot.tgz -C $ROS2_CROSS_ROOT/ros2_sysroot etc lib opt usr
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_humble ]; then
 tar -zxf $ROS2_CROSS_ROOT/ros2-prebuild.tgz -C $ROS2_CROSS_ROOT/ros2_humble .
fi
