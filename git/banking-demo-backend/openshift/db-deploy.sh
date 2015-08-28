#!/bin/bash -e

cd $(dirname $0)

. utils

new_env MYSQL_USER bankingapp
new_env MYSQL_PASS $(random)
new_env MYSQL_DATABASE bankingapp

. ../environment

oc create -f - <<EOF
kind: List
apiVersion: v1
items:
- kind: DeploymentConfig
  apiVersion: v1
  metadata:
    name: bankingapp-mysql
    labels:
      service: mysql
  spec:
    triggers:
    - type: ImageChange
      imageChangeParams:
        automatic: true
        containerNames:
        - bankingapp-mysql
        from:
          kind: ImageStreamTag
          name: mysql:latest
          namespace: openshift
    replicas: 1
    selector:
      deploymentconfig: bankingapp-mysql
    template:
      metadata:
        name: bankingapp-mysql
        labels:
          deploymentconfig: bankingapp-mysql
          service: mysql
      spec:
        containers:
        - name: bankingapp-mysql
          image: mysql
          ports:
          - containerPort: 3306
          env:
          - name: MYSQL_DATABASE
            value: "$MYSQL_DATABASE"
          - name: MYSQL_USER
            value: "$MYSQL_USER"
          - name: MYSQL_PASSWORD
            value: "$MYSQL_PASSWORD"

- kind: Service
  apiVersion: v1
  metadata:
    name: bankingapp-mysql
    labels:
      service: mysql
  spec:
    ports:
    - port: 3306
    selector:
      deploymentconfig: bankingapp-mysql
EOF
