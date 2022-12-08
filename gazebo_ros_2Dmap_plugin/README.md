# gazebo_ros_2Dmap_plugin
Gazebo simulator plugin to automatically generate a 2D occupancy map from the simulated world at a given certain height. 

This plugin was adapted from the [octomap plugin](https://github.com/ethz-asl/rotors_simulator/tree/master/rotors_gazebo_plugins) from ETH Zürich.

## How ti use docker environment
1. Clone
    ```shell
    git clone https://github.com/Decwest/gazebo_ros_2Dmap_plugin.git
    ```
2. Build docker image
    ```shell
    cd gazebo_ros_2Dmap_plugin/docker
    ./build.sh
    ```
3. Launch docker container (At first, you need catkin_make (cm alias is available))
    ```
    cd gazebo_ros_2Dmap_plugin/docker
    ./run.sh
    GAZEBO2ROSMAP$ cm
    ```

## Usage
Check out the plugin in your `catkin_ws` and build it with `catkin_make`.
To include the plugin, add the following line in between the `<world> </world>` tags of your Gazebo world file:

```
<plugin name='gazebo_occupancy_map' filename='libgazebo_2Dmap_plugin.so'>
    <map_resolution>0.1</map_resolution> <!-- in meters, optional, default 0.1 -->
    <map_height>0.3</map_height>         <!-- in meters, optional, default 0.3 -->
    <map_size_x>10</map_size_x>          <!-- in meters, optional, default 10 -->
    <map_size_y>10</map_size_y>          <!-- in meters, optional, default 10 -->
    <init_robot_x>0</init_robot_x>          <!-- x coordinate in meters, optional, default 0 -->
    <init_robot_y>0</init_robot_y>          <!-- y coordinate in meters, optional, default 0 -->
</plugin>
```

To generate the map, call the `/gazebo_2Dmap_plugin/generate_map` ros service:

```
rosservice call /gazebo_2Dmap_plugin/generate_map
```

The generated map is published on the `/map2d` ros topic. 

You can use the `map_saver` node from the `map_server` package inside ros navigation to save your generated map to a .pgm and .yaml file:

```
rosrun map_server map_saver -f <mapname> /map:=/map2d
```

If you use docker environment, the following command saves map in map directory.

```
rosrun map_server map_saver -f ~/catkin_ws/src/gazebo_ros_2Dmap_plugin/map/map /map:=/map2d
```

The last map generated with the ```/gazebo_2Dmap_plugin/generate_map``` call is saved.

## Hints

* To identify the connected free space the robot would discover during mapping, the plugin performs a wavefront exploration along the occupancy grid starting from the origin of the gazebo world coordinate system. Please ensure that the corresponding cell is in the continuous free space. 
* The plugin will map all objects in the world, including the robot. Remove all unwanted  objects before creating the map. 
