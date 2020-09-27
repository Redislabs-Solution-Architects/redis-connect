#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

source venv/bin/activate
python simple.py $SIMPLE
python simple.py $SIMPLE_P
python sentinel.py $SENTINEL
python sentinel.py $SENTINEL_P
python simpletls.py $SIMPLE_TLS
python simpletls.py $SIMPLE_P_TLS
python sentineltls.py $SENTINEL_TLS
python sentineltls.py $SENTINEL_P_TLS
deactivate
cd cluster
source venv/bin/activate
python cluster.py $CLUSTER
python cluster.py $CLUSTER_P
python clustertls.py $CLUSTER_TLS
python clustertls.py $CLUSTER_P_TLS
deactivate
cd "${DIR}"
