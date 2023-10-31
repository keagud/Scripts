#!/bin/bash



nb add "daily/$(date -I)/$(date +%H_%M_%S).md" --content "$1"
