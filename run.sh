#!/usr/bin/with-contenv bashio
set -e

SSH_DIR=~/.ssh

ROUTER_USER="$(bashio::config 'sslFromAsusRouter.routerUser')"
ROUTER_IP="$(bashio::config 'sslFromAsusRouter.routerIp')"
RSA_PRIVATE_KEY_PATH="$(bashio::config 'sslFromAsusRouter.rsaPrivateKeyPath')"
KEY_PATH_ON_ROUTER="$(bashio::config 'sslFromAsusRouter.keyFilePathOnRouter')"
CERT_PATH_ON_ROUTER="$(bashio::config 'sslFromAsusRouter.certFilePathOnRouter')"

echo "Getting Router Public RSA Key...."
ROUTER_RSA_KEY=$(ssh-keyscan -t rsa ${ROUTER_IP})

echo "Creating ${SSH_DIR}"
mkdir -p ${SSH_DIR}

echo "Setting id_rsa file..."
cp /config/${RSA_PRIVATE_KEY_PATH} ${SSH_DIR}/id_rsa
chmod 600 ${SSH_DIR}/id_rsa

echo "Touching ${SSH_DIR}/known_hosts..."
touch ${SSH_DIR}/known_hosts

echo "Setting ${SSH_DIR}/known_hosts Permission..."
chmod 644 ${SSH_DIR}/known_hosts

ls -lrt ${SSH_DIR}

echo "Saving know hosts..."
KNOW_HOST_SSH_SEARCH_RESULT=$(grep "${ROUTER_RSA_KEY}" ${SSH_DIR}/known_hosts)
if [[ -n "$KNOW_HOST_SSH_SEARCH_RESULT" ]]; then
	echo "Not known Host, adding..."
	echo "$ROUTER_RSA_KEY" >> ${SSH_DIR}/known_hosts;
else
	echo "Already known host..."
fi

echo "scping..."
scp -v ${ROUTER_USER}@${ROUTER_IP}:${KEY_PATH_ON_ROUTER} /ssl/
scp -v ${ROUTER_USER}@${ROUTER_IP}:${CERT_PATH_ON_ROUTER} /ssl/