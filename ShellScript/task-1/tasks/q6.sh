#!/bin/bash
while getopts 'C:f:k:l:n:o:c:v:ad' tags; do
    case ${tags} in
    C) command=${OPTARG} ;;
    f) fn=$OPTARG ;;
    l) ln=$OPTARG ;;
    n) contact=$OPTARG ;;
    o) company=$OPTARG ;;
    k) key=$OPTARG ;;
    c) head=$OPTARG ;;
    v) value=$OPTARG ;;
    a) ord="ascending" ;;
    d) ord="descending" ;;
    esac
done

MYCUSTOMTAB=''
if [[ $command == "insert" ]]; then
    echo $fn${MYCUSTOMTAB}","${MYCUSTOMTAB}$ln${MYCUSTOMTAB}","${MYCUSTOMTAB}$contact${MYCUSTOMTAB}","${MYCUSTOMTAB}$company >>contacts.csv

elif [[ $command == "edit" ]]; then

    touch temp.csv
    while read -r line; do

        tempname=$(echo $line | awk -F, '{print $1}')
        if [[ $key == $tempname ]]; then
            echo $fn${MYCUSTOMTAB}","${MYCUSTOMTAB}$ln${MYCUSTOMTAB}","${MYCUSTOMTAB}$contact${MYCUSTOMTAB}","${MYCUSTOMTAB}$company >>temp.csv

        else
            echo $line >>temp.csv
        fi
    done <contacts.csv

    cat temp.csv >contacts.csv
    rm temp.csv
elif [[ $command == "display" ]]; then
    echo "fname,lname,mobile,Office"
    if [[ $ord == "ascending" ]]; then
        sort -k1df contacts.csv
    else
        sort -k1rdf contacts.csv
    fi
elif [[ $command == "search" ]]; then
    if [[ $head == "fname" ]]; then
        column=0
    elif [[ $head == "lname" ]]; then
        column=1
    elif [[ $head == "mobile" ]]; then
        column=2
    fi

    while read -r line; do
        readarray -d "," -t comp <<<"$line"
        if [[ $value == ${comp[column]} ]]; then
            echo $line
        fi
    done <contacts.csv
elif [[ $command == "delete" ]]; then
    if [[ $head == "fname" ]]; then
        column=1
    elif [[ $head == "lname" ]]; then
        column=2
    elif [[ $head == "mobile" ]]; then
        column=3
    fi

    touch temp.csv
    while read -r line; do
        comp=$(echo $line | awk -v num=$column -F, '{printf "%s\n", $num}')
        # echo $comp $value
        if [[ $value != $comp ]]; then
            echo $line >>temp.csv
        fi
    done <contacts.csv
    cat temp.csv >contacts.csv
    rm temp.csv
fi
