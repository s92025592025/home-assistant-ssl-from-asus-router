#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

ROUTER_USER="$(bashio::config 'router_user')"
echo "ROUTER_USER: $ROUTER_USER"