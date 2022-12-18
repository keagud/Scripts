#!/bin/bash


tempfile=~/.local/pactemp/updateable
checkupdate(){
  mkdir -p ~/.local/pactemp
  checkupdates > "$tempfile"
  return $?
}

notif_update(){

  updates_count=$(cat "$tempfile" | wc -l)
  kernel_update=0

  if [[ $updates_count > 0 ]]; then 
    kernel_update=$(cat "$tempfile" | grep "^linux\s" -c) 

    echo -en "\e[1;32m"
    echo "$updates_count packages can be upgraded" | lolcat

    if [[ $kernel_update > 0 ]]; then 

      echo "New kernel is available!" | lolcat

    fi 

    echo -e "\e[0m"


  fi

}


notif_update
checkupdate &
