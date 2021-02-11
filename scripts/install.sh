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

#Ensure correct batch run
cp ../.user-config.xml ~/.phoronix-test-suite/user-config.xml

echo "Create suite"
phoronix-test-suite build-suite
