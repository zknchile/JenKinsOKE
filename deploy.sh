#!/bin/bash

sudo runuser -l opc -c "kubectl create namespace hello-python"
sudo runuser -l opc -c "kubectl create secret docker-registry ocirsecret --docker-server=${REGION}/${REGISTRY_NAMESPACE} --docker-username=${USER} --docker-password='${TOKEN}' -n hello-python"
sudo runuser -l opc -c "kubectl apply -f /var/lib/jenkins/workspace/hello-python-OKE_master/deployment.yml"
