#!/bin/bash
# build container
echo "RUN YOUR OWN IMAGE"

image="pattylo/airo_gpu:pytorch"

gpu_enabled="--gpus all"

echo "NOW RUNNING IMAGE -> CONTAINER"
echo "CONTAINER BASED ON IMAGE: $image"

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

sudo docker run \
  -it \
  --network host \
  --privileged \
  $gpu_enabled \
  --volume=$XSOCK:$XSOCK:rw \
  --volume=$XAUTH:$XAUTH:rw \
  --env="XAUTHORITY=${XAUTH}" \
  --env DISPLAY=$DISPLAY \
  --env TERM=xterm-256color \
  -v /dev:/dev \
  $image \
  /bin/bash 
