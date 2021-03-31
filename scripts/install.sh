#!/bin/bash

projectRoot=$(pwd)

if [ ! -e "$projectRoot/.token" ]; then
  echo "Installing Phoronix..."
  cd "$projectRoot/benchmarks/phoronix-test-suite/"
  ./install-sh
  touch $projectRoot/.token
fi

#Create TestFile dir and allow user to specify tests

if [ ! -d "$projectRoot/testfiles" ]; then 
  mkdir "$projectRoot/testfiles"
fi

if [ ! -a "$projectRoot/testfiles/testfile" ]; then
  touch "$projectRoot/testfiles/testfile"
fi  

testfile="$projectRoot/testfiles/testfile"

if [  $(wc -l < $testfile) -eq 0 ]; then
  echo "#Enter the tests you wish to install on their own line" >> $testfile
fi

"${EDITOR:-vi}" $testfile

#Read tests from testfile and install them

echo "Installing tests from testfile..."
while IFS= read -r line
  do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  yes | phoronix-test-suite install-test $line
done < $testfile

#Ensure correct batch run
cp "./.user-config.xml" "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/user-config.xml"
