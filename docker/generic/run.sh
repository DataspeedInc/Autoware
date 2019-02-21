#!/bin/bash

usage() { echo "Usage: $0 [-t <tag>] [-r <repo>] [-s <Shared directory>]" 1>&2; exit 1; }

# Defaults
XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
SHARED_DIR=/home/autoware/.autoware
HOST_DIR=/home/$USER/shared_dir
DOCKER_HUB_REPO="autoware/autoware"
TAG="latest-kinetic"

while getopts ":ht:r:s:" opt; do
  case $opt in
    h)
      usage
      exit
      ;;
    t)
      TAG=$OPTARG
      ;;
    r )
      DOCKER_HUB_REPO=$OPTARG
      ;;
    s)
      HOST_DIR=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo "Using $DOCKER_HUB_REPO:$TAG"
echo "Shared directory: ${HOST_DIR}"

if nvidia-smi > /dev/null 2>&1; then # Detect if nvidia is used
  if dpkg -s nvidia-docker2 > /dev/null 2>&1; then # Detect if nvidia-docker v2 is used
    echo "Will run with nvidia acceleration (nvidia-docker v2)"
    DOCKER_CMD="docker"
    RUN_ARG="--runtime=nvidia"
    TAG_SUFFIX="-nvidia"
  else
    echo "Will run without nvidia acceleration (nvidia-docker v1 - deprecated)"
    DOCKER_CMD="nvidia-docker"
    RUN_ARG=""
    TAG_SUFFIX=""
  fi
else
  echo "Will run without nvidia acceleration"
  DOCKER_CMD="docker"
  RUN_ARG=""
  TAG_SUFFIX=""
fi

$DOCKER_CMD run $RUN_ARG \
    -it --rm \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume=$HOST_DIR:$SHARED_DIR:rw \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    -u autoware \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    --net=host \
    twbabyduck/autoware:1.9.1-kinetic-opengl

