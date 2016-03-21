SIM_IP=192.168.0.101

PINT_DIR=/home/jcmarsh/research/PINT
CONFIG_DIR=$PINT_DIR/controllers/configs

# $1 # of iterations, $2 file prefix, $3 player time, $4 PINT time
runExperiment () {
    echo "**** Starting runExperiment $2, $1 iterations ****"
    for index in `seq 0 $1`; do
	timeout $3 player baseline.cfg > $2$index.txt &
	sleep 5
	timeout $4 $PINT_DIR/stage_control/basic $SIM_IP &
	sleep $4
	sleep 40
    done
    echo "**** Finished $2 ****"
    echo ""
}

# $1 iterations, $2 file prefix, $3 fault injection, $4 player time, $5 PINT time, $6 inject time
# example fault injection: "kill -9", "kill -s 37", "./inject_error"
runExperimentFaults() {
    echo "**** Starting runExperimentFaults $2 w/ $3, $1 iterations ****"
    for index in `seq 0 $1`; do
	timeout $4 player baseline.cfg > $2$index.txt &
	sleep 5
	timeout $5 $PINT_DIR/stage_control/basic $SIM_IP &
	sleep 5
	ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm > $2injector_$index.txt
	timeout $6 python injector.py false $3 >> $2injector_$index.txt &
	sleep $6
	ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm >> $2injector_$index.txt
	sleep 40
    done
    echo "**** Finished $2 ****"
    echo ""
}
