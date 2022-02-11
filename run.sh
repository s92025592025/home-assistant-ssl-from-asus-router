#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

echo "CONFIG_PATH: $CONFIG_PATH"
ls -alrt $CONFIG_PATH
cat $CONFIG_PATH

ROUTER_USER="$(bashio::config 'sslFromAsusRouter.routerUser')"
echo "ROUTER_USER: $ROUTER_USER"