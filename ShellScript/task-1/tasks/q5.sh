#!/bin/bash
prev=$pwd
if test "$1" != ""; then
    path="$1"
    cd $path
else
    path=$pwd
fi
MYCUSTOMTAB=''
touch dir.txt file.txt dirans.txt fileans.txt
for FILE in *; do
    if [[ -d $FILE ]]; then
        dirval=$(find $FILE -type f | wc -l)
        dirname=$FILE
        echo $dirname${MYCUSTOMTAB}"," $dirval "file(s)" >>dir.txt
    elif [[ -f $FILE ]]; then
        filesize=$(find "$FILE" -printf "%s")
        filename=$FILE
        echo $filesize $filename >>file.txt
    fi
done
sort -rk 2 dir.txt >>dirans.txt
sort -rn file.txt | awk '{print $2}' >>fileans.txt
echo "Directories:"
cat dirans.txt
echo
echo "Files:"
cat fileans.txt
rm dirans.txt fileans.txt dir.txt file.txt
cd $prev
