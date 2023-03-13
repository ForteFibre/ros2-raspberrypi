#!/bin/bash

if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot ]; then
 echo "Sysroot cannot be found"
 exit 1
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_humble ]; then
 echo "Prebuilt ROS base cannot be found"
 exit 1
fi


if [ ! -f "$ROS2_CROSS_ROOT/.PREBUILT" ]; then
  echo "Build Docker for cross building"
  docker build -t ros2_arm64_cross -f $ROS2_CROSS_ROOT/docker/Dockerfile_cross_compile $ROS2_CROSS_ROOT/docker
fi

if [ -z "$ROS2_WS" ]; then
  ROS2_WS=$PWD/ros2_ws
fi

if [ ! -d $ROS2_WS ]; then
  ROS2_WS=$HOME/ros2_ws
  echo "Fallback ROS workspace path to $ROS2_WS"
fi

if [ ! -d $ROS2_WS ]; then
  ROS2_WS=$PWD
  echo "Fallback ROS workspace path to $ROS2_WS"
fi

if [ ! -d $ROS2_WS ]; then
  echo "ROS workspace cannot be found"
  exit
fi

if [ ! -d "$ROS2_WS/src" ]; then
  echo "ROS source directory cannot be found"
  exit
fi


TTY_OPTS=
if [ -t 1 ]; then
  TTY_OPTS=-it
fi

docker run --rm $TTY_OPTS \
  --volume $ROS2_CROSS_ROOT/ros2_sysroot:/root/rootfs \
  --volume $ROS2_WS:/root/ros2_ws \
  --volume $ROS2_CROSS_ROOT/ros2_humble:/root/ros2 \
  -w /root/ros2_ws \
  ros2_arm64_cross
