#!/bin/bash
# stopword=$2
for word in $(<$2); do
    sed -ien "s/\<$word\>\s*//g" $1
done
word=$3
while IFS= read -r line; do
    p1="$(echo $line | grep -ow $word | wc -l)"
    p2="$(echo $line | sed 's/[^a-zA-Z0-9]/ /g' | wc -w)" 
    echo -n $line >> q4_output.txt
    echo -n " " >> q4_output.txt
    echo "$p1 $p2" | awk '{printf "%.5f\n", $1 / $2}' >> q4_output.txt
done < $1
