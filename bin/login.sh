#!/bin/bash

osc login -u $USER -p redhat --certificate-authority=/var/lib/openshift/openshift.local.certificates/ca/cert.crt --server=https://ose3-master.example.com:8443
