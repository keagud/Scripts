#!/usr/bin/bash
cat $1 | xclip -selection c && echo "clipped!" 

