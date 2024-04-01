#!/bin/bash



BATTERY_OUTPUT=""

function show_battery(){

  upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk ' $1 == "percentage:" || $1 == "state:" { print $2 }' | sed 's/\n//g'

}


function show_date(){
   date +'%a %Y-%m-%d %R'
}

while true; do
  show_battery
  show_date 
  sleep 30;
done
