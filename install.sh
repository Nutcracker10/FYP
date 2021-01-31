#!/bin/bash

. ./vars.sh

cd $phoronix
./install-sh


while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  yes | phoronix-test-suite install-test $line
done < $testfile
