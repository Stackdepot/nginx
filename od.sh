#!/bin/bash

if [[ $LOCALPORT == 3000 ]]
then
  echo "Meteor instance disconnected @ $LOCALHOST:$LOCALPORT"
  sed -i "/server $LOCALHOST:$LOCALPORT;/d" /instances 
  echo "Remove instance to Nginx config"
  INSTANCES="$(cat /instances)"
  TEMPLATE="$(cat /template)"
  CONFIG=$(eval "$TEMPLATE")
  echo "$CONFIG" > /etc/nginx/conf.d/default.conf
  nginx -s reload
fi