#!/bin/bash

. ./vars.sh
if [[ $(id -u) -ne 0 ]]; then
  echo "ERROR: run.sh must be run as root"
  exit 1
fi

./install.sh


