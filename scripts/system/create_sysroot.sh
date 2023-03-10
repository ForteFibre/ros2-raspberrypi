#!/bin/bash


if [ -z "$ROS2_CROSS_ROOT" ]; then
  echo "ROS2_CROSS_ROOT is not set"
  exit
fi

ROS2_SYSROOT="$ROS2_CROSS_ROOT/ros2_sysroot"
ROS2_SYSROOT_TAR="$ROS2_CROSS_ROOT/ros2_sysroot.tar"

echo "Docker cross-runner preparation"
docker run --privileged --rm tonistiigi/binfmt --install all

echo "Build Docker image"

docker buildx build -t sysroot-ubuntu -f $ROS2_CROSS_ROOT/docker/Dockerfile_sysroot $ROS2_CROSS_ROOT/docker

echo "Remove old Docker containers"

docker kill ros2_sysroot

docker rm ros2_sysroot

echo "Create new Docker container"

docker create --name ros2_sysroot sysroot-ubuntu

echo "Exporting Docker container..."

if [ -f $ROS2_SYSROOT_TAR ]; then
    rm $ROS2_SYSROOT_TAR
fi

docker container export -o $ROS2_SYSROOT_TAR ros2_sysroot

docker rm ros2_sysroot

echo "Uncompress sysroot..."

chmod 777 $ROS2_SYSROOT_TAR

if [ -d $ROS2_SYSROOT ]; then
    chmod 777 $ROS2_SYSROOT
    rm -rf $ROS2_SYSROOT
fi

mkdir -p $ROS2_SYSROOT

tar -xf $ROS2_SYSROOT_TAR -C $ROS2_SYSROOT etc lib opt usr


bash "$ROS2_CROSS_ROOT/scripts/system/fix_ld_conf.sh"
