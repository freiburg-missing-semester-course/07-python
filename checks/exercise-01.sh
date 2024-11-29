#!/bin/bash

awk 'BEGIN{status="UNKNOWN"} \
    /^s .*$/{status=$2} \
    /^.* search$/{search=$2;searchpercent=$3} \
    /^.* simplify$/{simplify=$2;simplifypercent=$3} \
    /^c total real time since initialization:/{totaltime=$7} \
    END{printf("%s,%s,%s,%s,%s,%s,%s\n", substr(FILENAME,3,length(FILENAME)-6), status,totaltime,search,0+searchpercent,simplify,0+simplifypercent)}' $1