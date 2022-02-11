#!/usr/bin/with-contenv bashio
set -e

ROUTER_USER="$(bashio::config 'sslFromAsusRouter.routerUser')"
ROUTER_IP="$(bashio::config 'sslFromAsusRouter.routerIp')"
ROUTER_SSH_HOST_KEY="$(bashio::config 'sslFromAsusRouter.routerSshHostKey')"
KEY_PATH_ON_ROUTER="$(bashio::config 'sslFromAsusRouter.keyFilePathOnRouter')"
CERT_PATH_ON_ROUTER="$(bashio::config 'sslFromAsusRouter.certFilePathOnRouter')"

ROUTER_RSA_KEY=$(ssh-keyscan -t rsa ${ROUTER_IP})

ls -lrt /data/.ssh

if bashio::fs.file_exists "/data/.ssh/known_hosts"; then
	KNOW_HOST_SSH_SEARCH_RESULT=$(grep "${ROUTER_RSA_KEY}" /data/.ssh/known_hosts)

	if [[ -n "$KNOW_HOST_SSH_SEARCH_RESULT" ]]; then
		echo "$ROUTER_RSA_KEY" >> /data/.ssh/known_hosts;
	fi
else
	mkdir -p /data/.ssh/
	echo "$(grep "${ROUTER_RSA_KEY}" /data/.ssh/known_hosts)" >> /data/.ssh/known_hosts;
fi

scp -v -i /data/.ssh/id_rsa -o UserKnownHostsFile=/data/.ssh/known_hosts ${ROUTER_USER}@${ROUTER_IP}:/tmp/etc/key.pem /ssl/
scp -v -i /data/.ssh/id_rsa -o UserKnownHostsFile=/data/.ssh/known_hosts ${ROUTER_USER}@${ROUTER_IP}:/tmp/etc/cert.pem /ssl/