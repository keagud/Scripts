#!/bin/bash

CACHE_FILE="$HOME/.cache/.once.cache"
TODAY="$( date +%F )"

if  [[ ! -f "$CACHE_FILE" ]]; then 
  mkdir -p "$HOME/.cache"
  touch "$CACHE_FILE"
fi

STORED_DATE="$(head "$CACHE_FILE" -n 1)"

if [[ "$STORED_DATE" == "$TODAY" ]]; then
  exit 2;
fi


echo "$TODAY" > "$CACHE_FILE"


