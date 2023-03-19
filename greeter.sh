#!/bin/bash

if  ! once.sh; then 
  exit 0
fi

UPDATES="$(checkupdates)"
UPDATEMSG="\t$(echo "$UPDATES" | wc -l) packages can be updated"
KERNELUPDATE=$(echo "$UPDATES" | grep -c -o "^linux\s")

KERNELMSG=""
if [[ KERNELUPDATE ]]; then
  KERNELMSG="\n\tKernel update available!"
fi

echo -e  "\n\033[1m\t$(date +"%A, %B %e %Y\t%-j/365" )\033[0m\n\n$UPDATEMSG$KERNELMSG" | lolcat -a

