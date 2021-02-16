#!/bin/bash

projectRoot=$(pwd)

#if [[ $(id -u) -ne 0 ]]; then
#  echo "ERROR: run.sh must be run as root"
#  exit 1
#fi

while getopts ":hlqr" opt; do
  case ${opt} in 

    h ) # Help
        echo "help"
      ;;

    l ) #List all installed tests
        phoronix-test-suite list-installed-tests
      ;;
    
    q ) # Quick - Go straight to running tests
        echo "Test (suite) to run:"
        read test_to_run
        phoronix-test-suite batch-run $test_to_run
        ./scripts/parser.sh
      ;;
    
    r ) # Remove installed tests
        echo "Removing installed tests"
        rm -rf /home/${SUDO_USER:-${USER}}/.phoronix-test-suite/installed-tests/
      ;;

    \?)
       echo "Usage: run [-h] [-q testname] [-r] [-t]"
      ;;
  esac
done

if (( $OPTIND == 1 )); then
  sudo "./scripts/install.sh"
  #run most recent test suite
  phoronix-test-suite batch-run $(ls -t /home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-suites/local/ | head -1)
  ./scripts/parser.sh
fi
