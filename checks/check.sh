#!/bin/bash

parse_argument() {
    while getopts ":g:d:" opt; do
        case $opt in
            g)
                github="$OPTARG"
                ;;
            d)
                debugq2="$OPTARG"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                ;;
        esac
    done
}

debugq2="no"
github="no"

parse_argument "$@"

echo "This is the script to check your solution"

echo "******* preparation ***********"
this_script=$(realpath "$0")
dir=$(dirname "$this_script")
cd "$dir"


function extract_values() {
  OUT=`../exercise-01.sh $1`
}
echo "***************** Exercise 1 *****************"

cd logs

for file in `ls *.log`
do
    extract_values $file
    if [ "`../../exercise-01.sh $file`" = $OUT ];
    then
       echo "correct output for $file"
    else
	echo "incorrect output for $file: got `../../exercise-01.sh $file` but expected $OUT"
	exit 1
    fi
done

cd ../

echo "***************** Exercise 2 *****************"


if [ $debugq2 = "yes" ];
then
    echo "*** checking the output of log files ***"
    OUT=`./exercise-02.sh logs | head -n5`

    hash=`./exercise-02.sh logs | head -n5 | sort -k1 -k3 | md5sum | cut -d ' ' -f 1`

    if [ `../exercise-02.sh logs | head -n5 | sort -k1 -k3 | md5sum | cut -d ' ' -f 1` = $hash ];
    then
	echo "correct output for directory"
    else
	echo "incorrect output for directory: got `./exercise-02.sh logs | head -n5 | sort -k1 -k3` (after sorting) but expected $OUT"
	exit 1
    fi
fi


echo "*** checking the zummarize part ***"

if [ `../exercise-02.sh logs | tail -n 1 | md5sum | cut -d ' ' -f 1` = `./exercise-02.sh logs | tail -n1 | md5sum | cut -d ' ' -f 1 ` ]
then
    echo "correct answer"
else
    echo "incorrect output for directory: got `./exercise-02.sh logs | tail -n 1` (last line only to allow for output before) but expected `./exercise-02.sh logs | tail -n1`"
    exit 1
fi



echo "***************** Exercise 3 *****************"

if [ $github = "yes" ];
then
    echo "skipping on github"
else
    # precalculated values: 132 120 148
    SAT=132
    UNSAT=120
    UNKNOWN=148
    if [ `../exercise-03.sh https://cca.informatik.uni-freiburg.de/missing-semester/ws23/cadical1.9-0j.tar.xz | tail -n 1 | md5sum | cut -d ' ' -f 1` = `printf "total: 400, SATISFIABLE: $SAT, UNSATISFIABLE: $UNSAT, UNKNOWN: $UNKNOWN\n" | md5sum | cut -d ' ' -f 1 ` ]
    then
	echo "correct answer"
    else
	echo "incorrect output for directory: got `../exercise-03.sh https://cca.informatik.uni-freiburg.de/missing-semester/ws23/cadical1.9-0j.tar.xz | tail -n 1` (last line only) but expected `printf "total: 400, SATISFIABLE: $SAT, UNSATISFIABLE: $UNSAT, UNKNOWN: $UNKNOWN"`"
	exit 1
    fi
fi


echo "***************** Exercise 4 *****************"

if [ `../exercise-04.sh logs | jq -S '.problems[]| join(",")' | sort -k1 | md5sum | cut -d ' ' -f 1` = `./exercise-04.sh | sort -k1 | md5sum | cut -d ' ' -f 1` ]
then
    echo "correct answer"
else
    echo "incorrect output for directory: got `../exercise-04.sh logs | jq -S '.problems[]| join(\",\")' | sort -k1` (after CSV conversion) but expected `./exercise-04.sh | sort -k1`"
    exit 1
fi
