#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

echo $CONFIG_PATH
ROUTER_USER="$(bashio::config 'router_user')"
echo "ROUTER_USER: $ROUTER_USER"