#!/bin/bash

LC_ALL=C awk 'function basename(file) {sub(".*/", "", file); return file }  \
     BEGIN{status="UNKNOWN"} \
    /^s .*$/{status=$2} \
    /^.* search$/{search=$2;searchpercent=$3} \
    /^.* simplify$/{simplify=$2;simplifypercent=$3} \
    /^c total real time since initialization:/{totaltime=$7} \
    END{printf("%s,%s,%1.2f,%1.2f,%1.2f,%1.2f,%1.2f\n", substr(basename(FILENAME),0,length(basename(FILENAME))-4), status,totaltime,search,0+searchpercent,simplify,0+simplifypercent)}' $1
