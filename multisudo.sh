#!/usr/bin/bash

log=setup.log
sudo_status=sudo_status.txt

cmd_file=$1

echo $$ >> $sudo_status

sudo_me(){

	while [ -f $sudo_status ]; do
		sudo -v
		echo "refreshed sudo env"
		sleep 5
	done &
}

echo "enter sudo credentials"
sudo -v
sudo_me

cmd=""
input_file="${1:-/dev/stdin}"
while IFS= read -r line; do
	if [[ $line =~ ^#.* ]]; then 
		cmd="${line:1}"
		continue
		
	fi

	$cmd $line


done < "$input_file"
rm $sudo_status
