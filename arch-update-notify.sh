#!/bin/bash


pacout=$(pacman -Qu)
upgradable=$(echo "$pacout" | wc -l)

kernelpat='^linux\s'

kmatch=$(echo "$pacout" | grep "$kernelpat" -c)

if [[ $upgradable ]]; then
  echo -en "\e[1;37m"
  echo "$upgradable packages can be updated"

  if [[ $kmatch > 0  ]]; then
    echo "new kernel version available!" | lolcat
  fi

  echo -e "\e[0m"
fi



