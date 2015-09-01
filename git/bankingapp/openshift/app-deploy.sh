#!/bin/bash -e

cd $(dirname $0)

. utils

new_env MYSQL_USER bankingapp
new_env MYSQL_PASS $(random)
new_env MYSQL_DATABASE bankingapp

. ../environment

oc create -f - <<EOF || true
kind: ImageStream
apiVersion: v1
metadata:
  name: bankingapp
  labels:
    service: bankingapp
EOF

oc create -f - <<EOF
kind: List
apiVersion: v1
items:
- kind: DeploymentConfig
  apiVersion: v1
  metadata:
    name: bankingapp
    labels:
      service: bankingapp
  spec:
    replicas: 1
    selector:
      deploymentconfig: bankingapp
    template:
      metadata:
        name: bankingapp
        labels:
          deploymentconfig: bankingapp
          service: bankingapp
      spec:
        containers:
        - name: bankingapp
          image: bankingapp
          ports:
          - name: http
            containerPort: 8080
          - name: ping
            containerPort: 8888
          - name: jolokia
            containerPort: 8778
          readinessProbe:
            exec:
              command:
              - /bin/bash
              - -c
              - /opt/eap/bin/readinessProbe.sh
          env:
          - name: DB_SERVICE_PREFIX_MAPPING
            value: bankingapp-mysql=DB
          - name: TX_DATABASE_PREFIX_MAPPING
            value: bankingapp-mysql=DB
          - name: DB_JNDI
            value: java:jboss/datasources/MySqlDS
          - name: DB_DATABASE
            value: "$MYSQL_DATABASE"
          - name: DB_USERNAME
            value: "$MYSQL_USER"
          - name: DB_PASSWORD
            value: "$MYSQL_PASS"
          - name: OPENSHIFT_DNS_PING_SERVICE_NAME
            value: bankingapp
          - name: OPENSHIFT_DNS_PING_SERVICE_PORT
            value: "8888"
          - name: DEBUG
            value: "true"
    triggers:
    - type: ConfigChange
    - type: ImageChange
      imageChangeParams:
        automatic: true
        containerNames:
        - bankingapp
        from:
          kind: ImageStream
          name: bankingapp
  
- kind: Service
  apiVersion: v1
  metadata:
    name: bankingapp
    labels:
      service: bankingapp
  spec:
    ports:
    - name: http
      port: 8080
    - name: ping
      port: 8888
    selector:
      deploymentconfig: bankingapp

- kind: Route
  apiVersion: v1
  metadata:
    name: bankingapp
    labels:
      service: bankingapp
  spec:
    to:
      name: bankingapp
EOF
