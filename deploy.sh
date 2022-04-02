#!/usr/bin/env bash

service docker restart

CURRENT_INSTANCE=$(docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")


if [ "$CURRENT_INSTANCE" ]
then
  docker rm $(docker stop $CURRENT_INSTANCE)
fi


docker pull $IMAGE_NAME


CONTAINER_EXISTS=$(docker ps -a | grep week3Lab)
if [ "$CONTAINER_EXISTS" ]
then
  docker rm -f week3Lab
fi


docker create -p 8443:8443 --name week3Lab $IMAGE_NAME

echo $privatekey > privatekey.pem

echo $server > server.crt

docker cp ./privatekey.pem week3Lab:/privatekey.pem

docker cp ./server.crt week3Lab:/server.crt

docker start week3Lab