#!/bin/bash

BASIC_TIME=300
SLEEP_TIME=310

if [ $# -lt 1 ]
then
    echo "Usage: sh ./run_empty_bench_test prepend_file"
    exit
fi

echo "Comments for Run:" > $1_comments.txt
cpufreq-info >> $1_comments.txt
ls -lh >> $1_comments.txt

echo "Running NMR case" >> $1_comments.txt
echo "Running NMR case"
date
timeout $BASIC_TIME ./GEVoteTest > $1_NMR.txt &
ps -Ao pid,cpuid,maj_flt,min_flt,rtprio,pri,nice,pcpu,stat,wchan:20,comm >> $1_comments.txt
sleep $SLEEP_TIME

echo "Running SMR case" >> $1_comments.txt
echo "Running SMR case"
date
timeout $BASIC_TIME ./GEVoteTest VoterM SMR > $1_SMR.txt &
ps -Ao pid,cpuid,maj_flt,min_flt,rtprio,pri,nice,pcpu,stat,wchan:20,comm >> $1_comments.txt
sleep $SLEEP_TIME

echo "Running DMR case" >> $1_comments.txt
echo "Running DMR case"
date
timeout $BASIC_TIME ./GEVoteTest VoterM DMR > $1_DMR.txt &
ps -Ao pid,cpuid,maj_flt,min_flt,rtprio,pri,nice,pcpu,stat,wchan:20,comm >> $1_comments.txt
sleep $SLEEP_TIME

echo "Running TMR case" >> $1_comments.txt
echo "Running TMR case"
date
timeout $BASIC_TIME ./GEVoteTest VoterM TMR > $1_TMR.txt &
ps -Ao pid,cpuid,maj_flt,min_flt,rtprio,pri,nice,pcpu,stat,wchan:20,comm >> $1_comments.txt
sleep $SLEEP_TIME
