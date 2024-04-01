upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk ' $1 == "percentage:" || $1 == "state:" { print $1 }'
