#!/bin/bash

. ./vars


#phoronix-test-suite result-file-to-csv "$testName"

#ls ~/.phoronix-test-suite/test-results/

for result in "/home/$USER/.phoronix-test-suite/test-results/*"
do
  phoronix-test-suite result-file-to-csv  $(basename $result)
  mv "/home/$USER/$(basename $result).csv" "$projectRoot/results"  
done
