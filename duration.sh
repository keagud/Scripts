#!/bin/bash


total_duration=0.0

for file in $1; do 
  duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
  total_duration=$(echo "$total_duration + $duration" | bc)
done


python3 -c "m, s = divmod(int($total_duration), 60); print(f'{m:03}:{s:02}')"
