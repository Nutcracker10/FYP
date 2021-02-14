#!/bin/bash

run_install_scripts () {
  #./scripts/testfile_generate.sh
  ./scripts/install.sh
}


if [[ $(id -u) -ne 0 ]]; then
  echo "ERROR: run.sh must be run as root"
  exit 1
fi

while getopts ":hlqr" opt; do
  case ${opt} in 

    h ) # Help
        echo "help"
      ;;

    l ) #List all tests
        phoronix-test-suite list-all-tests
      ;;
    
    q ) # Quick - Go straight to running tests
        echo "Test (suite) to run:"
        read test_to_run
        phoronix-test-suite batch-run $test_to_run
      ;;
    
    r ) # Cleanup - Remove installed tests
        ./scripts/cleanup.sh
      ;;

    \?)
       echo "Usage: run [-h] [-q testname] [-r] [-t]"
      ;;
  esac
done

if (( $OPTIND == 1 )); then
  run_install_scripts()
fi
