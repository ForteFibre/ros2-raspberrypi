#!/bin/bash

setup_colcon_cross() {
  if [ -z "$ROS2_CROSS_ROOT" ]; then
    echo "ROS2_CROSS_ROOT is not set"
    return
  fi

  if [ ! -d $ROS2_CROSS_ROOT/ros2_sysroot ]; then
    echo "Sysroot cannot be found"
    return
  fi

  if [ ! -d $ROS2_CROSS_ROOT/ros2_humble ]; then
    echo "Prebuilt ROS base cannot be found"
    return
  fi


  if [ ! -f "$ROS2_CROSS_ROOT/.PREBUILT" ]; then
    echo "Build Docker for cross building"
    docker build -t ros2_arm64_cross -f $ROS2_CROSS_ROOT/docker/Dockerfile_cross_compile $ROS2_CROSS_ROOT/docker
  fi

  colcon_cross_build() {
    TTY_OPTS=
    if [ -t 1 ]; then
        TTY_OPTS=-it
    fi

    echo "$@"

    docker run --rm $TTY_OPTS \
      --volume $ROS2_CROSS_ROOT/ros2_sysroot:/root/rootfs \
      --volume $PWD:/root/ros2_ws \
      --volume $ROS2_CROSS_ROOT/ros2_humble:/root/ros2 \
      --env UID=`id -u` \
      --env GID=`id -g` \
      -w /root/ros2_ws \
      ros2_arm64_cross "$@"
    
    echo "Rewriting path of packages"
    find $PWD/install/share/ament_index/resource_index/parent_prefix_path -type f -exec sed -i s%/root/ros2%$PWD% {} ";"
  }

  export -f colcon_cross_build

  echo "colcon_cross_build is now available!"
}

setup_colcon_cross