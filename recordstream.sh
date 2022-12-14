#!/bin/bash
#
# recordstream.sh, Record an MP3 Stream for a lenght of time.
#
# Copyright (C) 2022 Jonathan J. Miner
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# $Id:$
# Jonathan J. Miner <jon@jjminer.org>

def_len=3600

stream=$1
len=$2
now=`date '+%Y%m%d-%H%M%S'`
prefix=$3

if [[ -z "$stream" ]]; then
    echo "ERROR: a stream URL is required."
    echo
    echo "Usage: $0 stream [length-in-seconds] [prefix]"
    echo "      default length: $def_len"
    echo "      prefix will be used in place of 'recordstream' in the file name."
    exit 3
fi

if [[ -z "$len" ]]; then
    echo "No length (in seconds) specified, defaulting to $def_len";
    len=$def_len
fi

if [[ -z "$prefix" ]]; then
    prefix=recordstream
fi

file=$prefix-$now.mp3

printf "Recording $stream for %d seconds (%02dh:%02dm:%02ds) to %s\n\n" $len $((len/3600)) $((len%3600/60)) $((len%60)) $file

curl -o $file -m $len $stream

