#!/bin/bash

result=$(basename  "$(ls -t "/home/${SUDO_USER:-${USER}}/.phoronix-test-suite/test-results/" | head -1)" )

phoronix-test-suite result-file-to-csv $result

file=$(ls -Art /home/${SUDO_USER:-${USER}}/*.csv | tail -n 1)

#mv /home/${SUDO_USER:-${USER}}/*.csv "./results/"
mv $file "./results/"
echo "Result moved to results/"
