#!/bin/bash

if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot ]; then
 echo "Sysroot cannot be found"
 exit 1
fi

if [ ! -f "$ROS2_CROSS_ROOT/.PREBUILT" ]; then
  echo "Build Docker for cross building"
  docker build -t ros2_arm64_cross -f $ROS2_CROSS_ROOT/docker/Dockerfile_cross_compile $ROS2_CROSS_ROOT/docker
fi

TTY_OPTS=
if [ -t 1 ]; then
  TTY_OPTS=-it
fi

echo "Building ROS system..."
docker run --rm $TTY_OPTS \
  --volume $PWD/ros2_sysroot:/root/rootfs \
  --volume $PWD/ros2_humble:/root/ros2 \
  -w /root/ros2 \
  --entrypoint /bin/bash \
  --env UID=`id -u` \
  --env GID=`id -g` \
  ros2_arm64_cross \
  /scripts/build_ros.sh
