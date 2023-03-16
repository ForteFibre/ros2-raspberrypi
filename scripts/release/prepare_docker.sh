#!/bin/bash

if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

touch "$ROS2_CROSS_ROOT/.PREBUILT"

cat $ROS2_CROSS_ROOT/ros2-cross.tgz | gunzip -c - | docker load

if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot/etc ]; then
 mkdir -p $ROS2_CROSS_ROOT/ros2_sysroot
 tar -zxf $ROS2_CROSS_ROOT/ros2-sysroot.tgz -C $ROS2_CROSS_ROOT/ros2_sysroot etc lib opt usr
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_humble/install ]; then
 mkdir -p $ROS2_CROSS_ROOT/ros2_humble
 tar -zxf $ROS2_CROSS_ROOT/ros2-prebuild.tgz -C $ROS2_CROSS_ROOT/ros2_humble .
fi
