#!/bin/bash


`find $1 -name \*.log -exec \
  awk 'function basename(file) {sub(".*/", "", file); return file }  \
    BEGIN{status="UNKNOWN"} \
    /^s .*$/{status=$2} \
    /^.* search$/{search=$2;searchpercent=$3} \
    /^.* simplify$/{simplify=$2;simplifypercent=$3} \
    /^c total real time since initialization:/{totaltime=$7} \
    END{printf("%s,%s,%s,%s,%s,%s,%s\n", substr(basename(FILENAME),0,length(basename(FILENAME))-4), status,totaltime,search,0+searchpercent,simplify,0+simplifypercent)}' {} \; > /tmp/exercise-02.log`

SAT=`grep ",SATISFIABLE" /tmp/exercise-02.log | wc -l`

UNSAT=`grep ",UNSATISFIABLE" /tmp/exercise-02.log | wc -l`

UNKNOWN=`grep ",UNKNOWN" /tmp/exercise-02.log | wc -l`

ALL=`wc -l /tmp/exercise-02.log | cut -d ' ' -f 1`

cat  /tmp/exercise-02.log # | sort -k1 -k3
rm -rf /tmp/exercise-02.log

printf "total: $ALL, SATISFIABLE: $SAT, UNSATISFIABLE: $UNSAT, UNKNOWN: $UNKNOWN\n"