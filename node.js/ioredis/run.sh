#!/bin/bash

echo "                                   ";
echo "                     (             ";
echo " (        (      (   )\ )  (       ";
echo " )\   (   )(    ))\ (()/(  )\  (   ";
echo "((_)  )\ (()\  /((_) ((_))((_) )\  ";
echo " (_) ((_) ((_)(_))   _| |  (_)((_) ";
echo " | |/ _ \| '_|/ -_)/ _\` |  | |(_-< ";
echo " |_|\___/|_|  \___|\__,_|  |_|/__/ ";
echo "                                   ";


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

npm install
node simple.js $SIMPLE
node simple.js $SIMPLE_P
node sentinel.js $SENTINEL
node sentinel.js $SENTINEL_P
node cluster.js $CLUSTER
node cluster.js $CLUSTER_P