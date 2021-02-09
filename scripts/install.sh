#!/bin/bash

. ./vars

echo "Installing Phoronix..."
cd $phoronix
#./install-sh

echo "Installing tests from testfile..."
while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  yes | phoronix-test-suite install-test $line
done < $testfile

echo "Create suite"
phoronix-test-suite build-suite
