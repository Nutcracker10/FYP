#!/bin/bash

. ./vars.sh

#cd $phoronix
#./install-sh


#create basic testfile if it does not exist
if [ ! -d "./testfile" ] ; then
  mkdir './testfile'
  touch './testfile/testfile'
  echo "#Basic system test" > $testfile
  echo "scimark2" >> $testfile
  echo "himeno" >> $testfile
  echo "fio" >> $testfile
  echo "ramspeed" >> $testfile
fi

while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  yes | phoronix-test-suite install-test $line
done < $testfile
