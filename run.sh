#!/usr/bin/with-contenv bashio
set -e

SSH_DIR=~/.ssh

ROUTER_USER="$(bashio::config 'sslFromAsusRouter.routerUser')"
ROUTER_IP="$(bashio::config 'sslFromAsusRouter.routerIp')"
SSH_ACCESS_PRIVATE_RSA_KEY="$(bashio::config 'sslFromAsusRouter.accessSshPrivateRsaKey')"
KEY_PATH_ON_ROUTER="$(bashio::config 'sslFromAsusRouter.keyFilePathOnRouter')"
CERT_PATH_ON_ROUTER="$(bashio::config 'sslFromAsusRouter.certFilePathOnRouter')"

ROUTER_RSA_KEY=$(ssh-keyscan -t rsa ${ROUTER_IP})

mkdir -p ${SSH_DIR}
echo "${SSH_ACCESS_PRIVATE_RSA_KEY}" > ${SSH_DIR}/id_rsa
cat ${SSH_DIR}/id_rsa
chmod 600 ${SSH_DIR}/id_rsa

ls -lrt ${SSH_DIR}

if bashio::fs.file_exists "${SSH_DIR}/known_hosts"; then
	KNOW_HOST_SSH_SEARCH_RESULT=$(grep "${ROUTER_RSA_KEY}" ${SSH_DIR}/known_hosts)

	if [[ -n "$KNOW_HOST_SSH_SEARCH_RESULT" ]]; then
		echo "$ROUTER_RSA_KEY" >> ${SSH_DIR}/known_hosts;
	fi
else
	
	echo "$(grep "${ROUTER_RSA_KEY}" ${SSH_DIR}/known_hosts)" >> ${SSH_DIR}/known_hosts;
fi

scp -v ${ROUTER_USER}@${ROUTER_IP}:/tmp/etc/key.pem /ssl/
scp -v ${ROUTER_USER}@${ROUTER_IP}:/tmp/etc/cert.pem /ssl/