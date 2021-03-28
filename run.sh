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
        started=$(date +%s)
        phoronix-test-suite batch-run $test_to_run
        now=$(date +%s)
        difference=$(expr $now - $started)
        ./scripts/parser.sh
        
        echo "Do you wish to save the time taken to run benchmarks as dimension?"
        select yn in "Yes" "No"; do
          case $yn in 
            Yes) echo $difference"," >> "./results/test_results.csv"; break;;
            No) exit;;
          esac
        done
      
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
  started=$(date +%s)
  #run most recent test suite
  phoronix-test-suite batch-run $(ls -t /home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-suites/local/ | head -1)
  now=$(date +%s)
  difference=$(expr $now - $started)
  
  ./scripts/parser.sh
  
  echo "Do you wish to save the time taken to run benchmarks as dimension?"
  select yn in "Yes" "No"; do
    case $yn in 
      Yes)  echo "$difference," >> "./results/test_results.csv"; break;;
      No)   exit;;
    esac
  done

  echo "Do you wish to add a dimension?"
  select yn in "Yes" "No"; do
    case $yn in 
      Yes)  echo "Enter value: ";
            read value ;
            echo "$value," >> "./results/test_results.csv";
            break;;

      No) exit;;

fi
