#!/bin/bash
echo " ____  ____  ____  ____  ___  _____ ";
echo "(  _ \( ___)(  _ \(_  _)/ __)(  _  )";
echo " )   / )__)  )(_) )_)(_( (_-. )(_)( ";
echo "(_)\_)(____)(____/(____)\___/(_____)";
echo 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

#goland redigo
cd ${DIR}/simple
go build
./simple $SIMPLE
./simple $SIMPLE_P
cd ${DIR}/sentinel
go build
./sentinel $SENTINEL
./sentinel $SENTINEL_P
cd ${DIR}/cluster
go build
./cluster $CLUSTER
./cluster $CLUSTER_P
cd ${DIR}
