#!/bin/bash

for dir in "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/installed-tests/*"
do
  

  for p_test in $(ls $dir)
  do
    #echo $p_test
    yes | phoronix-test-suite remove-installed-test $(ls $p_test)
  done 

done
