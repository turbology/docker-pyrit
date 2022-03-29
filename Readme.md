# Docker-Pyrit

> Taming Pyrit dependencies by packaging via Docker

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
  - [Docker](#docker)
  - [Nvidia-docker (Optional)](#nvidia-docker-optional)
- [Usage](#usage)
- [TODO](#todo)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prerequisites

### Docker

In order to run Docker images you must have the Docker daemon installed.

* Ubuntu - https://docs.docker.com/install/linux/docker-ce/ubuntu/
* Docker is also available for other platforms.  

### Nvidia-docker (HIGHLY Recommended)
Uncomment last two parts of Dockerfile  (modules/cpyrit_cuda and modules/cpyrit_opencl) to take advantage of latest compute runtime.
If you have Intel-OpenCL in place, it will take advantage of it as well.


If you have a GPU that supports CUDA, you can install Nvidia's [special Docker daemon](https://github.com/NVIDIA/nvidia-docker) that can pass the enhanced capabilities your GPU to the container.

Nvidia-docker does not currently support MacOS but I have had success running it on Ubuntu 16.04.

Before you install nvidia-docker:

* Install the latest Nvidia graphics drivers for your platform.  These must be the official binary drivers, nvidia-docker will not work with Nouveau.
* Do not install Docker.  If you have Docker installed, the nvidia-docker package will attempt to integrate with it but this gave me nothing but trouble.  In the end, I purged Docker CE and let nvidia-docker install the version it wanted.

## Personal Note
#*******************************************************************************
# Branch out to allow continue usage of Pyrit in newer Ubuntu 20.04 enviroment *
#*******************************************************************************
#
# This build pull newer cuda-11.4 base image, to make use of newer Nvidia CUDA
# runtime.
#
# You can comment it to skip modules for cpyrit_cuda or cpyrit_opencl, or both if
# you have error compiling it.
# Pyrit will run fine with our wihtout Cuda/OpenCL capable devices AFTER you
# built the docker.
#
# If you have Intel-OpenCL installed, it will take advantage of Intel CPU and
# Intel GPU as well.  Check out Intel OneAPI runtime library and drivers.
#
# The code should work on WSL2 as well for Ubuntu/Debian linux distribution.
#
# If you compiling CUDA or OpenCL, dont't forget
#  docker run --gpus all ,and
#  apt-get install nvidia-cuda-toolkit2 prerequisite
#
# This is kinda new yet excited for me because is my first git commit, docker built,
# and python code debugging. Any comments are welcome.
#
#
# On branch Ubuntu20.04
# Changes to be committed:
#       modified:   Dockerfile
#       new file:   modules/cpyrit_cuda/setup.py
#       new file:   modules/cpyrit_opencl/setup.py
#       new file:   setup.py
#
#
#Branch out to allow continue usage of Pyrit in newer Ubuntu 20.04 enviroment *
#*******************************************************************************
#
# This build pull newer cuda-11.4 base image, to make use of newer Nvidia CUDA
# runtime.
#
# You can comment it to skip modules for cpyrit_cuda or cpyrit_opencl, or both if
# you have error compiling it.
# Pyrit will run fine with our wihtout Cuda/OpenCL capable devices AFTER you
# built the docker.
#
# If you have Intel-OpenCL installed, it will take advantage of Intel CPU and
# Intel GPU as well.  Check out Intel OneAPI runtime library and drivers.
#
# The code should work on WSL2 as well for Ubuntu/Debian linux distribution.
#
# If you compiling CUDA or OpenCL, dont't forget
#  docker run --gpus all ,and
#  apt-get install nvidia-cuda-toolkit2 prerequisite
#
# This is kinda new yet excited for me because is my first git commit, docker built,
# and python code debugging. Any comments are welcome.

## Usage

>TODO

## TODO

Features to add later:

* Add docker-compose to combine Pyrit with MySQL as a storage back end
* Use multi-stage Dockerfile to build the final artifact on the `nvidia/cuda:runtime` to reduce image size
