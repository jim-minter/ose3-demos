#!/bin/bash -e

cd $(dirname $0)
. ../environment
. utils

./db-deploy.sh
./app-deploy.sh
./app-build.sh
