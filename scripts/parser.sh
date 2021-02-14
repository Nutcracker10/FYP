#!/bin/bash

. ./vars

results="~/.phoronix-test-suite/test-results"

testName="$results/*"

phoronix-test-suite result-file-to-csv "$results/*"

mv "~/$testName" "$projectRoot/results"
