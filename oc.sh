#!/bin/bash

if [[ $LOCALPORT == 3000 ]]
then
  echo "Meteor instance connected @ $LOCALHOST:$LOCALPORT"
  echo "server $LOCALHOST:$LOCALPORT;" >> /instances
  echo "Adding instance to Nginx config"
  INSTANCES="$(cat /instances)"
  TEMPLATE="$(cat /template)"
  CONFIG=$(eval "$TEMPLATE")
  echo "$CONFIG" > /etc/nginx/conf.d/default.conf
  nginx -s reload
fi