#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

echo "CONFIG_PATH: $CONFIG_PATH"
ls -alrt $CONFIG_PATH
cat $CONFIG_PATH
ROUTER_USER="$(bashio::config 'home_assistant_ssl_from_asus_router.router_user')"
echo "ROUTER_USER: $ROUTER_USER"