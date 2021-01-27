#!/bin/bash

. ./vars.sh

#cd $phoronix
#./install-sh

while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  echo $line
done < $testfile
