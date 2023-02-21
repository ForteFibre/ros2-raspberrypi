#!/bin/bash

if [ ! -f .PREBUILT ]; then
  echo "Build Docker image"
  docker build -t rpi4_cross_compile -f Dockerfile_cross_compile .
fi

docker run -it \
  --volume $PWD/ros2-sysroot:/root/rootfs \
  --volume $PWD/ros2_ws:/root/ros2_ws \
  --volume $PWD/ros2_humble:/root/ros2 \
  -w /root/ros2_ws \
  rpi4_cross_compile
