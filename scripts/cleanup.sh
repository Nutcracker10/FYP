#!/bin/bash
. ./vars

while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  yes | phoronix-test-suite remove-installed-test $line
done < $testfile

