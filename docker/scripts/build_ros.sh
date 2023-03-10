#!/bin/bash

echo "Importing ROS source"
mkdir -p src
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src

echo "Ignore some packages"
touch src/ros/ros1_bridge/COLCON_IGNORE
touch src/ros2/rviz/COLCON_IGNORE
touch src/ros/urdfdom/COLCON_IGNORE
touch src/ros2/urdf/COLCON_IGNORE
touch src/ros/kdl_parser/COLCON_IGNORE
touch src/ros/resource_retriever/COLCON_IGNORE
touch src/ros/robot_state_publisher/COLCON_IGNORE
touch src/ros2/demos/COLCON_IGNORE
touch src/ros-visualization/COLCON_IGNORE
touch src/ros/ros_tutorials/turtlesim/COLCON_IGNORE

echo "Building"
bash /scripts/cross_compile.sh
