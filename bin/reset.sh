#!/bin/bash

# nb: doesn't do projects

for rc in deploymentconfig replicationcontroller build buildconfig imagerepository images pod route service; do
  items=$(osc get $rc | tail -n +2 | awk '{print $1}')
  for i in $items; do
    osc delete $rc $i >/dev/null
  done
  echo $rc
done
