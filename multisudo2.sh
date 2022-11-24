#!/usr/bin/bash


source_process=$$
sudo_me(){

	while [ -f $sudo_status ]; do
		sudo -v
		echo -e  "refreshed sudo env\n"
		sleep 10
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
