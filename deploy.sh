#!/usr/bin/env bash

CURRENT_INSTANCE=$(docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")


if [ "$CURRENT_INSTANCE" ]
then
  docker rm $(docker stop $CURRENT_INSTANCE)
fi


docker pull $IMAGE_NAME


CONTAINER_EXISTS=$(docker ps -a | grep exampleapp)
if [ "$CONTAINER_EXISTS" ]
then
  docker rm exampleapp
fi


docker create -p 8443:8443 --name exampleapp $IMAGE_NAME

echo $privatekey > privatekey.pem

echo $server > server.crt

docker cp ./privatekey.pem exampleapp:/privatekey.pem

docker cp ./server.crt exampleapp:/server.crt

docker start exampleapp