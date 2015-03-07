#!/bin/bash

# nb: doesn't do projects

for rc in build buildconfig deploymentconfig imagerepository images pod replicationcontroller route service; do
  echo $rc
  osc get $rc
  echo
done
