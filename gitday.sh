#!/bin/bash

# Get the current date in YYYY-MM-DD format for 1 day ago
day=$(date +"%Y-%m-%d")

# Use git log to retrieve commit messages from the past day
git log --since="$day 00:00:00" --until="$day 23:59:59" --pretty=format:"%ad %s"  --date=format:'%H:%M' --reverse

