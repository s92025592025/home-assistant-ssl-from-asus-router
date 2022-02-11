#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -lrt /ssl

ROUTER_USER="$(bashio::config 'sslFromAsusRouter.routerUser')"
echo "ROUTER_USER: $ROUTER_USER"