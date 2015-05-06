#!/bin/bash

# nb: doesn't get projects

for resource_type in builds buildconfigs deploymentconfigs imagerepositories images pods replicationcontrollers resourcequotas routes services templates
do
  echo "# $resource_type"
  osc get $resource_type | sed -e 's/^/  /'
  echo
done
