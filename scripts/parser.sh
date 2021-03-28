#!/bin/bash

result=$(basename  "$(ls -t "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-results/" | head -1)" )

phoronix-test-suite result-file-to-csv $result

file=$(ls -Art /home/${SUDO_USER:-${USER}}/*.csv | tail -n 1)

#Pre-process the csv
sed -i -e '1,24d' $file
cut --complement -f 1-2 -d, $file >> "./results/test_results.csv"

#mv /home/${SUDO_USER:-${USER}}/*.csv "./results/"
mv $file "./results/"
echo "Result moved to results/"

#remove unnecessary details
#for f in "./results/"
#do
#  echo $f
#  sed -i -e '1,24d' $f
#  cut --complement -f 1-2 -d, $f >> results.csv
#done


