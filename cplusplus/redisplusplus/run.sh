#!/bin/bash

echo '    ┬─┐┌─┐┌┬┐┬┌─┐   ┌─┐┬  ┬ ┬┌─┐   ┌─┐┬  ┬ ┬┌─┐ '
echo '    ├┬┘├┤  │││└─┐───├─┘│  │ │└─┐───├─┘│  │ │└─┐ '
echo '    ┴└─└─┘─┴┘┴└─┘   ┴  ┴─┘└─┘└─┘   ┴  ┴─┘└─┘└─┘ '

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#C++ redisplusplus if hiredis and redisplusplus compiled without TLS support

printf "\nSimple....\n"
g++ -std=c++11 -o simple  simple.cpp -lredis++ -lhiredis -pthread
./simple $SIMPLE
./simple $SIMPLE_P

printf "\nSentinel TLS....\n"
g++ -std=c++11 -o sentinel  sentinel.cpp -lredis++ -lhiredis -pthread
./sentinel $SENTINEL
./sentinel $SENTINEL_P

printf "\nCluster....\n"
g++ -std=c++11 -o cluster  cluster.cpp -lredis++ -lhiredis -pthread
./cluster $CLUSTER
./cluster $CLUSTER_P
