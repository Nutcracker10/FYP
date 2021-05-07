#!/bin/bash

projectRoot=$(pwd)

#if [[ $(id -u) -ne 0 ]]; then
#  echo "ERROR: run.sh must be run as root"
#  exit 1
#fi

while getopts ":hiloqr" opt; do
  case ${opt} in 

    h ) # Help
        cat './.help'
      ;;

    i) #Install new tests
       ./scripts/install.sh
      ;;

    l ) #List all installed tests
        phoronix-test-suite list-installed-tests
      ;;

    o ) #Suggest optimal result from testfile
        ./scripts/optimise.py
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
        select yn in "yes" "no"; do
          case $yn in 
            yes) echo $difference"," >> "./results/test_results.csv"; break;;
            no) exit;;
          esac
        done
      
      ;;
    
    r ) # Remove all installed tests
        echo "Removing all installed tests"
        rm -rf /home/${SUDO_USER:-${USER}}/.phoronix-test-suite/installed-tests/
      ;;

    \?)
       echo "Usage: run [-h] [-q testname] [-r] [-t]"
      ;;
  esac
done

if (( $OPTIND == 1 )); then
  
  if [ ! -e "./.token" ]; then
    sudo "./scripts/install.sh"
  fi

  echo "Create the suite of tests you wish to run"
  phoronix-test-suite build-suite
  

  started=$(date +%s)
  
  #run most recent test suite
  phoronix-test-suite batch-run $(ls -t /home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-suites/local/ | head -1)
  
  now=$(date +%s)
  difference=$(expr $now - $started)
  
  ./scripts/parser.sh
  
  echo "Do you wish to save the time taken to run benchmarks as a dimension?"
  select yn in "yes" "no"; do
    case $yn in 
      yes)  echo "$difference," >> "./results/test_results.csv"; break;;
      no)   exit;;
    esac
  done

  echo "Do you wish to add a dimension from outside of the benchmarks?(i.e cost of machine)"
  select yn in "yes" "no"; do
    case $yn in 
      yes)  echo "Enter value: ";
            read value ;
            echo "$value," >> "./results/test_results.csv";
            break;;

      no) exit;;
    esac
  done

  ./scripts/optimise.py

fi
