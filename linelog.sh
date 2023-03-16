#!/bin/bash

   # git log  --pretty=tformat: --numstat -bw --after="$(date -I) 00:00" --before="$(date -I) 23:59" | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "%s\t%s\t%s\t",add,subs,loc}' >> ~/.l.tsv

target_date=$(date -I)

for flag in $@; do

  if [[ $flag =~ -y ]]; then
    target_date=$(date -I -d "yesterday")
    break;
  fi

done


   get_lines(){
mkdir -p ~/Code/logs

added=0
removed=0
net=0
echo -e "Project\tAdded\tRemoved\tNet"

for dn in $(find $1 -type d -name .git); do
  cd "$dn"
  res=$(git log  --pretty=tformat: --numstat --ignore-all-space --ignore-matching-lines="^[:space:]*.[:space:]*" --ignore-blank-lines --after="$target_date 00:00" --before="$target_date 23:59" | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "%s\t%s\t%s\t",add,subs,loc}')

  if  ! [[ $res =~ [0-9] ]]; then
    continue
  fi

  #echo "$res"
  echo -e "$( basename $(dirname $dn))\t$res"


  a=($res)
  added=$(( added + $(( a[0] )) ))
  removed=$(( removed + $(( a[1] )) ))
  net=$(( net + $(( a[2] )) ))


done

echo -e "Total\t$added\t$removed\t$net"

}

mkdir -p ~/Code/logs

get_lines ~ $@ | column -t | tee ~/Code/logs/"${target_date}"