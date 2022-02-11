#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

bashio::log.debug "CONFIG_PATH: $CONFIG_PATH"
ROUTER_USER="$(bashio::config 'home-assistant-ssl-from-asus-router.router_user')"
echo "ROUTER_USER: $ROUTER_USER"