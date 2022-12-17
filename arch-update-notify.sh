#!/bin/bash


pacout=$(checkupdates)
upgradable=$(( $(echo "$pacout" | wc -l) - 1 ))

kernelpat='^linux\s'

kmatch=$(echo "$pacout" | grep "$kernelpat" -c)

if [[ $upgradable > 0 ]]; then
  echo -en "\e[1;37m"
  echo "$upgradable packages can be updated"

  if [[ $kmatch > 0  ]]; then
    echo "new kernel version available!" | lolcat
  fi

  echo -e "\e[0m"
fi



