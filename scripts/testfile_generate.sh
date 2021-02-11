#!/bin/bash

. ./vars

#create basic testfile if it does not exist
if [ ! -d "../testfiles" ] ; then
  mkdir '../testfiles'
fi
if [ ! -e "../testfiles/testfile/" ]; then
  touch '../testfiles/testfile'
  echo "#Basic system test" > $testfile
  echo "scimark2" >> $testfile
  echo "himeno" >> $testfile
  echo "fio" >> $testfile
  echo "ramspeed" >> $testfile
fi

