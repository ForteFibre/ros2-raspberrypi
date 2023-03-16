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

colcon_cross() {
    TTY_OPTS=
    if [ -t 1 ]; then
        TTY_OPTS=-it
    fi

    echo "$@"

    docker run --rm $TTY_OPTS \
        --volume $ROS2_CROSS_ROOT/ros2_sysroot:/root/rootfs \
        --volume $PWD:/root/ros2_ws \
        --volume $ROS2_CROSS_ROOT/ros2_humble:/root/ros2 \
        -w /root/ros2_ws \
        ros2_arm64_cross "$@"
}

export -f colcon_cross

echo "colcon_cross is now available!"