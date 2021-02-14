#!/bin/bash

#. ../vars

projectRoot=$(pwd)
sed -i "s+projectRoot=""+projectRoot="$projectRoot"+" vars

if [ ! -e "$projectRoot/.token" ]; then
  echo "Installing Phoronix..."
  cd "$projectRoot/benchmarks/phoronix-test-suite/"
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
cp "./.user-config.xml" "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/user-config.xml"

echo "Create the suite of tests you wish to run"
phoronix-test-suite build-suite
