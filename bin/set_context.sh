#!/bin/bash

if [ -z "$1" ]; then
  echo "usage: $0 context"
  $(dirname $0)/list-contexts.py
  exit 1
fi

openshift ex config use-context "$1"
