#!/bin/bash

this_script=$(realpath "$0")
dir=$(dirname "$this_script")

`find $1 -name \*.log -exec \
  $dir/exercise-01.sh {} \; > /tmp/exercise-02.log`

SAT=`grep ",SATISFIABLE" /tmp/exercise-02.log | wc -l`

UNSAT=`grep ",UNSATISFIABLE" /tmp/exercise-02.log | wc -l`

UNKNOWN=`grep ",UNKNOWN" /tmp/exercise-02.log | wc -l`

ALL=`wc -l /tmp/exercise-02.log | cut -d ' ' -f 1`

cat  /tmp/exercise-02.log # | sort -k1 -k3
rm -rf /tmp/exercise-02.log

printf "total: $ALL, SATISFIABLE: $SAT, UNSATISFIABLE: $UNSAT, UNKNOWN: $UNKNOWN\n"