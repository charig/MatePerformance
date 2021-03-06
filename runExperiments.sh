#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
if [ ! -d $SCRIPT_PATH ]; then
    echo "Could not determine absolute dir of $0"
    echo "Maybe accessed with symlink"
fi

ALL=false

if [ "$1" == "All" ]
then
    ALL=true
    shift
fi

if [[ "$1" == "dynMetrics"  ]]
then
    "$SCRIPT_PATH/RunScripts/runDynMetrics.sh"
fi

if [[ "$ALL" == true || "$1" == "AreWeFast" || "$1" == "Inherent" || "$1" == "IndividualActivations" || "$1" == "Readonly" || "$1" == "Tracing" || "$1" == "ReflectiveCompilation" ]]
then
    set -e # make script fail on first error
#    systemctl stop gdm
#    systemctl stop cron
#    systemctl stop ondemand
    
    docker run --privileged=true -v "$SCRIPT_PATH/Data:/Data" mate_toplas_19 \
        /opt/MatePerformance/Scripts/runBenchs.sh /opt/MatePerformance/mate.conf /Data /opt/Benchmarks/AreWeFast/ /opt/Som/ /opt/TruffleMate/ /opt/RTruffleMate/MOInShape/ /opt/RTruffleMate/MOInObject /opt/Pharo /opt/graal \
        $@
    
fi



