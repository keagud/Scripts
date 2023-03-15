#!/bin/bash

echo "Formatting with black..."

if  black . ; then 
  echo "Formatting succeeded!"
else
  echo "Formatting failed! bailing out"
  exit 2
fi 


 if ruff . --per-file-ignores __init__.py:F401 --fix --show-fixes  --show-source  ; then
   echo "Problems found, fix them!"
   exit 2
else
  echo "Everything looks good!"
fi


