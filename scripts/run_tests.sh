#!/bin/bash

. ./vars

while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  phoronix-test-suite run-test  $line
done < $testfile

