#!/bin/bash

ffmpeg -i "$1" -vn -acodec libmp3lame -ac 1 -ab 160k -ar 48000 "$2"
