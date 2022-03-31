#!/usr/bin/env bash

CURRENT_INSTANCE=$(docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")


if [ "$CURRENT_INSTANCE" ]
then
  docker rm $(docker stop $CURRENT_INSTANCE)
fi


docker pull $IMAGE_NAME


CONTAINER_EXISTS=$(docker ps -a | grep integration_app)
if [ "$CONTAINER_EXISTS" ]
then
  docker rm integration_app
fi


docker create -p 8443:8443 --name integration_app $IMAGE_NAME

echo $privatekey > privatekey.pem

echo $server > server.crt

docker cp ./privatekey.pem integration_app:/privatekey.pem

docker cp ./server.crt integration_app:/server.crt

docker start integration_app