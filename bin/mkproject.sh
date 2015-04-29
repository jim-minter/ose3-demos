#!/bin/bash

if [ $# -ne 2 ]; then
  echo "usage: $0 project_name admin_user"
  exit 1
fi

osadm new-project "$1" --display-name="$1" --description="$1-description" --admin="$2"
