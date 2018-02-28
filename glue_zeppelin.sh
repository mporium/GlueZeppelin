#!/bin/bash

# This script expects to be run from the zeppelin root directory

# Check that a Dev Endpoint hostname has been given
if [ -z ${DEV_ENDPOINT_HOST} ]; then
  (>&2 echo "ERROR: Please define the hostname for the Dev Endpoint by setting DEV_ENDPOINT_HOST")
fi

# Check that the location of a private key file has been given
if [ -z ${PRIVATE_KEY_FILE} ]; then
  (>&2 echo "ERROR: Please define the location of a private key file by setting PRIVATE_KEY_FILE")
else
  # Check that the private key file exists
  if [ ! -f ${PRIVATE_KEY_FILE} ]; then
    (>&2 echo "ERROR: The private key file '${PRIVATE_KEY_FILE}' could not be found.")
  fi
fi

# Forward the local port 9007 to AWS Glue
# We copy the key because it has to have the correct permissions in order to be accepted by ssh
cp ${PRIVATE_KEY_FILE} conf/key.pem
chmod 700 conf/key.pem
ssh -f -o "StrictHostKeyChecking no" -o "ServerAliveInterval 30" -i conf/key.pem -4NTL 9007:169.254.76.1:9007 glue@${DEV_ENDPOINT_HOST}

# Start the zeppelin server
exec bin/zeppelin.sh
