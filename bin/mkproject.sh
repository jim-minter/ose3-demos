#!/bin/bash

if [ -z "$1" ]; then
  echo "usage: $0 project"
  exit 1
fi

osc create -f - <<EOF
kind: Project
apiVersion: v1beta1
metadata:
  name: $1
  annotations:
    description: $1-description
displayName: $1-displayname
EOF

openshift ex config set-context "$1" --cluster=master --user=admin --namespace="$1"
openshift ex config use-context "$1"
