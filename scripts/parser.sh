#!/bin/bash

for result in "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-results/*"
do
  phoronix-test-suite result-file-to-csv  $(basename $result)
  mv "/home/${SUDO_USER:-${USER}}/$(basename $result).csv" "$projectRoot/results"  
done
