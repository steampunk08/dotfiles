#!/bin/bash

tempo=$1
pts=$(echo 1/$1 | sfc -p 2)

ffmpeg -i $2 -filter_complex "[0:v]setpts=$pts*PTS[v];[0:a]atempo=$tempo[a]" -map "[v]" -map "[a]" $HOME/ffmpeg/output_$2
