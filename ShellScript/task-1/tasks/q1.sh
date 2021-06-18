#!/bin/bash

while IFS= read -r line; do
  input=$line

  n=${#input}

  echo -n ${input:0:4} >> q1_output.txt
  for ((i = 0; i < n - 4; i++)); do
    echo -n "#" >> q1_output.txt
  done
  echo >> q1_output.txt
done < $1
