#!/bin/bash

. ./vars.sh

#cd $phoronix
#./install-sh


#create basic testfile if it does not exist
if [ ! -d "./testfile" ] ; then
  mkdir './testfile'
  touch './testfile/testfile'
  echo "#Basic system test" > $testfile
  echo "SciMark" >> $testfile
  echo "Himeno Benchmark" >> $testfile
  echo "Flexible IO Tester" >> $testfile
  echo "RAMspeed SMP" >> $testfile
fi

while IFS= read -r line
do
  if  [[ $line == '#'* ]]; then
    continue
  fi
  echo $line
done < $testfile
