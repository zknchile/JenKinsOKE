#!/bin/bash

sudo runuser -l opc -c "kubectl create namespace ${OCINAMESPACE}"
sudo runuser -l opc -c "kubectl create secret docker-registry ocirsecret --docker-server=${REGION}/${REGISTRY_NAMESPACE} --docker-username=${OCIUSER} --docker-password='${TOKEN}' -n ${OCINAMESPACE}"
sudo runuser -l opc -c "kubectl apply -f /var/lib/jenkins/workspace/hello-python-OKE_master/deployment.yaml"
