#!/bin/bash
echo " ____  ____  ____  ____  ___  _____ ";
echo "(  _ \( ___)(  _ \(_  _)/ __)(  _  )";
echo " )   / )__)  )(_) )_)(_( (_-. )(_)( ";
echo "(_)\_)(____)(____/(____)\___/(_____)";
echo 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck source=/dev/null
source ${DIR}/../../testscripts/env.sh

printf "\nSimple....\n"
cd "${DIR}"/simple
go build
./simple $SIMPLE
./simple $SIMPLE_P

printf "\nSimple TLS....\n"
cd "${DIR}"/simpletls
go build
./simpletls $SIMPLE_TLS
./simpletls $SIMPLE_P_TLS

printf "\nSentinel....\n"
cd "${DIR}"/sentinel
go build
./sentinel $SENTINEL
./sentinel $SENTINEL_P

printf "\nCluster....\n"
cd "${DIR}"/cluster
go build
./cluster $CLUSTER
./cluster $CLUSTER_P
cd "${DIR}"
