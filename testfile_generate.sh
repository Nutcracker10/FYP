#!/usr/bin/bash

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

