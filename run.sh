#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "ERROR: run.sh must be run as root"
  exit 1
fi

while getopts ":hqrt" opt; do
  case ${opt} in 
    h ) # Help
      ;;
    q ) # Quick
      ;;
    r ) # run tests
      ;;
    t ) # Edit testfile
      ;;
    \?)
      echo "Usage: run [-h] [-q] [-r] [-t]"
      ;;
  esac
done
