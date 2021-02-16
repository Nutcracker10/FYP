#!/bin/bash

result=$(basename  "$(ls -t "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-results/" | head -1)" )

phoronix-test-suite result-file-to-csv $result

#for result in $results
#do
#  #echo $result
#  #basename "$result"
#  phoronix-test-suite result-file-to-csv  $(basename "$result")
#done
  
mv /home/${SUDO_USER:-${USER}}/*.csv "../results/"
