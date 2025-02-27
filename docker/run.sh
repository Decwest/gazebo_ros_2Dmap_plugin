#!/bin/bash

cd `dirname $0`

# xhost +
xhost +local:user
if [ ! -e /home/${USER}/.gazebo ]; then
    mkdir /home/${USER}/.gazebo
fi
docker run -it \
--privileged \
--runtime=nvidia \
--env=DISPLAY=$DISPLAY \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-v "/home/${USER}/.Xauthority:/home/${USER}/.Xauthority" \
--env="QT_X11_NO_MITSHM=1" \
--rm \
-v "/$(pwd)/global_ros_setting.sh:/ros_setting.sh" \
-v "/$(pwd)/ros_workspace:/home/${USER}/catkin_ws/" \
-v "${PWD}/config/terminator_config:/home/${USER}/.config/terminator/config" \
-v "/$(pwd)/../gazebo_ros_2Dmap_plugin:/home/${USER}/catkin_ws/src/gazebo_ros_2Dmap_plugin" \
-v "/home/${USER}/.gazebo:/home/${USER}/.gazebo" \
-v /etc/group:/etc/group:ro \
-v /etc/passwd:/etc/passwd:ro \
-v /etc/localtime:/etc/localtime:ro \
-v /media:/media \
-v /dev:/dev \
--net host \
${USER}/gazebo2rosmap

