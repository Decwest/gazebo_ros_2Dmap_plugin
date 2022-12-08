FROM osrf/ros:noetic-desktop-full
ARG USER=initial
ARG GROUP=initial
ARG UID=1000
#FROM $base_image
RUN echo base image: ${base_image}

#######################################################################
##                   install additional packages                     ##
#######################################################################
WORKDIR  /
# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt update 
RUN apt install -y ros-$ROS_DISTRO-navigation

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

RUN apt install python-is-python3 -y
RUN apt install net-tools -y

#######################################################################
##                            delete cash                            ##
#######################################################################
RUN rm -rf /var/lib/apt/lists/*

#######################################################################
##                         make sudoer user                          ##
#######################################################################

ARG USER
ARG USER_ID
 
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -u $USER_ID -s /bin/bash ${USER} && \
    echo "${USER}:${USER}" | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#######################################################################
##              make user accessible to usb and so on                ##
#######################################################################
RUN adduser ${USER} dialout
RUN adduser ${USER} tty
RUN adduser ${USER} video
RUN adduser ${USER} root

# USER root
USER ${USER}

RUN echo "export PS1='\[\e[1;31;40m\]GAZEBO2ROSMAP\[\e[0m\] \u:\w\$ '">> ~/.bashrc
RUN echo "source /ros_setting.sh">> ~/.bashrc

ARG workspace
WORKDIR ${workspace}
