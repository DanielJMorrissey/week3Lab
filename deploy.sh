#!/usr/bin/env bash

CURRENT_INSTANCE=$(docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")


if [ "$CURRENT_INSTANCE" ]
then
  docker rm -f $(docker stop $CURRENT_INSTANCE)
fi


docker pull $IMAGE_NAME


CONTAINER_EXISTS=$(docker ps -a | grep week3Lab1)
if [ "$CONTAINER_EXISTS" ]
then
  docker rm -f week3Lab1
fi


docker create -p 8443:8443 --name week3Lab1 $IMAGE_NAME

echo $privatekey > privatekey.pem

echo $server > server.crt

docker cp ./privatekey.pem week3Lab1:/privatekey.pem

docker cp ./server.crt week3Lab1:/server.crt

docker start week3Lab1