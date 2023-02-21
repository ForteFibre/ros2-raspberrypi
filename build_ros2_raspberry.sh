#!/bin/bash

if [ -f Dockerfile_cross_compile ]; then
  echo "Build Docker image"
  docker build -t rpi4_cross_compile -f Dockerfile_cross_compile .
fi

if [ ! -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot ]; then
 echo "Sysroot cannot be found"
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_humble ]; then
 echo "Prebuilt ROS2 binary for aarch64 cannot be found"
fi

ROS2_WS=$PWD/ros2_ws
if [ ! -d $ROS2_WS ]; then
  ROS2_WS=$HOME/ros2_ws
fi

if [ ! -d $ROS2_WS ]; then
  echo "ros2_ws cannot be found"
  exit
fi

docker run -it \
  --volume $ROS2_CROSS_ROOT/ros2_sysroot:/root/rootfs \
  --volume $ROS2_WS:/root/ros2_ws \
  --volume $ROS2_CROSS_ROOT/ros2_humble:/root/ros2 \
  -w /root/ros2_ws \
  rpi4_cross_compile
