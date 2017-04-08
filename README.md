# Dockered-VirtualT
Dockerized VirtualT

Requires the messy use of xhost + before running. will be fixed and done properly eventually

docker build -t virtualt .

docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix virtualt
