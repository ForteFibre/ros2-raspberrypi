#!/bin/bash


echo "Docker cross-runner preparation"
docker run --privileged --rm tonistiigi/binfmt --install all

echo "Build Docker image"

docker buildx build -t sysroot-ubuntu -f Dockerfile_sysroot .

echo "Remove old Docker containers"

docker kill ros2-sysroot-ubuntu

docker rm ros2-sysroot-ubuntu

echo "Create new Docker container"

docker create --name ros2-sysroot-ubuntu sysroot-ubuntu

echo "Exporting Docker container..."

if [ -f ros2-sysroot-ubuntu-rootfs.tar ]; then
    rm ros2-sysroot-ubuntu-rootfs.tar
fi


docker container export -o ros2-sysroot-ubuntu-rootfs.tar ros2-sysroot-ubuntu

docker rm ros2-sysroot-ubuntu

echo "Uncompress sysroot..."

chmod 777 ros2-sysroot-ubuntu-rootfs.tar

if [ -d ros2-sysroot-ubuntu-rootfs ]; then
    chmod 777 ros2-sysroot-ubuntu-rootfs
    rm -rf ros2-sysroot-ubuntu-rootfs
fi



mkdir ros2-sysroot-ubuntu-rootfs

tar -xf ros2-sysroot-ubuntu-rootfs.tar -C ros2-sysroot-ubuntu-rootfs etc lib opt usr


bash fix_ld_conf.sh
