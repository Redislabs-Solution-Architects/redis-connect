#!/bin/bash

echo "   _   _   _   _   _   _   _  ";
echo "  / \ / \ / \ / \ / \ / \ / \ ";
echo " ( r | e | d | i | s | p | y )";
echo "  \_/ \_/ \_/ \_/ \_/ \_/ \_/ ";
echo
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

source venv/bin/activate
printf "\nCluster....\n"
python simple.py $SIMPLE
python simple.py $SIMPLE_P

printf "\nSentinel....\n"
python sentinel.py $SENTINEL
python sentinel.py $SENTINEL_P

printf "\nSimple TLS....\n"
python simpletls.py $SIMPLE_TLS
python simpletls.py $SIMPLE_P_TLS

printf "\nSentinel TLS....\n"
python sentineltls.py $SENTINEL_TLS
python sentineltls.py $SENTINEL_P_TLS
deactivate

cd cluster
source venv/bin/activate
printf "\nCluster....\n"
python cluster.py $CLUSTER
python cluster.py $CLUSTER_P

printf "\nCluster TLS....\n"
python clustertls.py $CLUSTER_TLS
python clustertls.py $CLUSTER_P_TLS
deactivate

cd "${DIR}"
