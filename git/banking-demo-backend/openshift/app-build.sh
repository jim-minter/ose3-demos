#!/bin/bash -e

cd $(dirname $0)
. ../environment
. utils

oc create -f - <<EOF || true
kind: ImageStream
apiVersion: v1
metadata:
  name: bankingapp
  labels:
    service: bankingapp
EOF

oc create -f - <<EOF
kind: BuildConfig
apiVersion: v1
metadata:
  name: bankingapp
  labels:
    service: bankingapp
spec:
  triggers:
  - type: Generic
    generic:
      secret: secret
  - type: GitHub
    github:
      secret: secret
  - type: ImageChange
  strategy:
    type: Source
    sourceStrategy:
      from:
        kind: ImageStreamTag
        name: jboss-eap6-openshift:6.4
        namespace: openshift
  source:
    type: Git
    git:
      uri: $GITURL
      ref: master
#      ref: Feature-SaveCustomerDetails
  output:
    to:
      kind: ImageStreamTag
      name: bankingapp:latest
EOF
