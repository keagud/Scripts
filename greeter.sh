#!/bin/bash

if  ! once.sh; then 
  exit 0
fi

UPDATES="$(checkupdates)"
UPDATEN=$(echo "$UPDATES" | grep -E -cvo '^\s*$')

UPDATEMSG=""

if [[ $UPDATEN > 0 ]]; then
  UPDATEMSG="\t\n$UPDATEN packages can be updated"
fi

KERNELUPDATE=$(echo "$UPDATES" | grep -c -o "^linux\s")

KERNELMSG=""
if [[ $KERNELUPDATE > 0 ]]; then
  KERNELMSG="\n\tKernel update available!"
fi

echo -e  "\n\033[1m\t$(date +"%A, %B %e %Y\t%-j/365" )\033[0m\n$UPDATEMSG$KERNELMSG" | lolcat -a

