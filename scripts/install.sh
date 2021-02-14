#!/bin/bash

. ./vars

if [ ! -e "$projectRoot/.token" ]; then
  echo "Installing Phoronix..."
  cd $phoronix
  ./install-sh
  touch $projectRoot/.token
fi

#echo "Installing tests from testfile..."
#while IFS= read -r line
#do
#  if  [[ $line == '#'* ]]; then
#    continue
#  fi
#  yes | phoronix-test-suite install-test $line
#done < $testfile

#Ensure correct batch run
cp "../.user-config.xml" "/home/$USER/.phoronix-test-suite/user-config.xml"

echo "Create suite"
phoronix-test-suite build-suite
