#!/usr/bin/env bash
sudo apt update && sudo apt install nodejs npm

sudo npm install -g pm2

pm2 stop example_app

cd week3Lab

npm install
echo $privatekey > privatekey.pem
echo $SERVER > server.crt

pm2 start ./bin/www --name example_app