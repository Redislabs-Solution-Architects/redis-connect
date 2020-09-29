#!/bin/bash

echo '    ┬─┐┌─┐┌┬┐┬┌─┐   ┌─┐┬  ┬ ┬┌─┐   ┌─┐┬  ┬ ┬┌─┐  ╔╦╗╦  ╔═╗'
echo '    ├┬┘├┤  │││└─┐───├─┘│  │ │└─┐───├─┘│  │ │└─┐   ║ ║  ╚═╗'
echo '    ┴└─└─┘─┴┘┴└─┘   ┴  ┴─┘└─┘└─┘   ┴  ┴─┘└─┘└─┘   ╩ ╩═╝╚═╝'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

# If hireis and redisplusplus is compiled with TLS  use these commands

printf "\nSimple....\n"
g++ -std=c++11 -o simple  simple.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
./simple $SIMPLE
./simple $SIMPLE_P

printf "\nSentinel....\n"
g++ -std=c++11 -o sentinel  sentinel.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
./sentinel $SENTINEL
./sentinel $SENTINEL_P

printf "\nCluster....\n"
g++ -std=c++11 -o cluster  cluster.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
./cluster $CLUSTER
./cluster $CLUSTER_P

printf "\nSimple TLS....\n"
g++ -std=c++11 -o simpletls  simpletls.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
./simpletls $SIMPLE_TLS
./simpletls $SIMPLE_P_TLS

printf "\nSentinel TLS....\n"
g++ -std=c++11 -o sentineltls  sentineltls.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
./sentineltls $SENTINEL_TLS
./sentineltls $SENTINEL_P_TLS

printf "\nCluster TLS....\n"
g++ -std=c++11 -o clustertls  clustertls.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
./clustertls $CLUSTER_TLS
./clustertls $CLUSTER_P_TLS