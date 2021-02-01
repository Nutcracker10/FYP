#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "ERROR: run.sh must be run as root"
  exit 1
fi

while getopts ":hlqrt" opt; do
  case ${opt} in 
    h ) # Help
      echo "help"
      ;;

    l ) #List all tests
      phoronix-test-suite list-all-tests
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

if (( $OPTIND == 1 )) ; then
  ./scripts/testfile_generate.sh
  ./scripts/install.sh
fi
