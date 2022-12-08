#!/bin/bash -x

docker build  --tag ${USER}/gazebo2rosmap --build-arg USER=${USER} --build-arg USER_ID=`id -u` --build-arg workspace="/home/${USER}/catkin_ws" .
