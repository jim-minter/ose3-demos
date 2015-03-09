#!/bin/bash

# nb: doesn't delete projects or pushed docker images

osc delete builds,buildconfigs,deploymentconfigs,imagerepositories,images,pods,replicationcontrollers,routes,services

# bug?

osc delete pods
