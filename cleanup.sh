#!/usr/bin/bash
. ./vars.sh

while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  phoronix-test-suite remove-installed-test $line
done < $testfile

