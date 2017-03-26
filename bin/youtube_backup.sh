#!/bin/bash

set -e

pushd /mnt/KingGhidora/media/shared/youtube_likes 
date >> log
/usr/local/bin/youtube-dl --no-progress -i --download-archive archive_list.txt --audio-quality 0 https://www.youtube.com/playlist?list=LLBkKM6OCxNzgW8TWxZeDn_w 2 >&1 >> log 
popd
