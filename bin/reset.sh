#!/bin/bash

if [ $USER = root ]; then
  echo "$0: won't run as root."
  exit 1
fi

# nb: doesn't delete projects or pushed docker images

osc delete builds,buildconfigs,deploymentconfigs,imagerepositories,pods,replicationcontrollers,routes,services,templates --all

# bug 1?

osc delete pods --all

# bug 2?

# don't delete images...
