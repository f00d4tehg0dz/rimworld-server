#!/bin/bash -ex
# Sample run script.  Primarly used in build / testing

docker rm rimworld
docker run -it -p 25555:25555/udp -p 25555:25555/tcp -v /home/ubuntu/Documents/Rimworld:/rimworld \
--name rimworld \
f00d4tehg0dz/rimworld-server:build
