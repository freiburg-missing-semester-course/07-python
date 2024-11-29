#!/bin/bash

# You want to change the Python call on the last line!


# this code is here to make sure that the scripts really really finds the script you are writing
# DO NOT CHANGE
directory=$1 #first argument of the script
this_script=$(realpath "$0")
dir=$(dirname "$this_script")

# TODO: change here, but keep the $dir (it is the path where this script is, so if `python3
# ./src/my_awesome_script.py --json --dir <log_dir>` works in your terminal, use `python3
# $dir/src/my_awesome_script.py --dir $1`)
python3 $dir/my_awesome_script.py --json --directory $directory