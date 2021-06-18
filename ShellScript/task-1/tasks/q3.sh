#!/bin/bash
if test "$1" != ""
  then
    para="$1"    
else
    para='para.txt'
fi

# para='para.txt'
echo "1. Words - start with ‘s’ and is not follow by ‘a’"
grep -wo 's[[:alnum:]]*' $para | grep -wv 'sa.*'
echo "2. Word starts with ‘w’ and is followed by ‘h’"
grep -wo 'wh[[:alnum:]]*' $para
echo "3. Word starts with ‘t’ and is followed by ‘h’"
grep -wo 'th[[:alnum:]]*' $para
echo "4. Word starts with ‘a’ and is not followed by ‘n’"
grep -wo 'a[[:alnum:]]*' $para | grep -wv 'an.*'
