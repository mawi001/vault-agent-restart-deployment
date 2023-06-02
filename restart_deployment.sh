#!/bin/sh
# Get deployment
DEPLOYMENT=$(echo $HOSTNAME | sed '$s/-\w*$//g;$s/-\w*$//g')

DEPLOYMENT_STATUS=$(kubectl rollout status deploy $DEPLOYMENT --watch=false)

echo $DEPLOYMENT_STATUS | grep 'successfully rolled out'
if [ $? == 0 ]; then
    echo "Restarting deployment ${DEPLOYMENT}"
    kubectl rollout restart deploy $DEPLOYMENT
else
    echo "Rollout already in progress. Skipping"
    echo "${$DEPLOYMENT_STATUS}"
fi
