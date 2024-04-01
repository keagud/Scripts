#!/bin/bash

# First make sure youtube-dl is installed with the latest git version:
#
#  pipx install "git+https://github.com/ytdl-org/youtube-dl.git"  


# Then run with 


youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' --write-auto-sub --output '%(playlist_index)02d - %(title)s.%(ext)s' $1
