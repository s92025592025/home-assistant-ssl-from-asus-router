#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

ROUTER_USE="$(bashio::config 'router_user')"