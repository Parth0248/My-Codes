#!/bin/bash
curryear=$(date +'%Y')
currmonth=$(date +'%m')
currdate=$(date +'%d')

while IFS= read -r line; do
	d=$(echo $line | awk '{print $NF}' | tr -d '/')
	date=${d:0:2}
	month=${d:2:2}
	year=${d: -4}

	name=$(echo $line | awk 'NF{NF--};1' )
	age=$((curryear - year))

	if [[ $month > $currmonth ]]; then
		age=$((curryear - year - 1))
	else
		if [[ $month == $currmonth ]]; then
			if [[ $date > $currdate ]]; then
				age=$((curryear - year - 1))
			fi
		fi
	fi

	echo $name $age >> q2_output.txt

done < $1
