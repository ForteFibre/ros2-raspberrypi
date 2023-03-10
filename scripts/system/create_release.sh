#!/bin/bash

if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

echo "## Create Cross builder image"
echo "Remove old Docker containers"

docker kill ros2_cross
docker rm ros2_cross

echo "Create new Docker container"
docker create --name ros2_cross ros2_arm64_cross

echo "Exporting Docker container..."

docker container export -o - ros2_cross | gzip -c > $ROS2_CROSS_ROOT/ros2-cross.tgz
docker rm ros2_cross

echo "## Create env image"

tar -czf -C $ROS2_CROSS_ROOT ros2-sysroot.tgz ros2_sysroot
tar -czf -C $ROS2_CROSS_ROOT ros2-prebuild.tgz ros2_humble