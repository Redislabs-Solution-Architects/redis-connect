#!/bin/bash

echo " ____ ____ ____ ____ ____ ____ ____ ____ ";
echo "||r |||e |||d |||i |||s |||- |||r |||b ||";
echo "||__|||__|||__|||__|||__|||__|||__|||__||";
echo "|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|";
echo "                                         ";
echo "                                         ";
echo "                                         ";
echo "                                         ";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}"/../../testscripts/env.sh

bundle

printf "\nSimple....\n"
ruby simple.rb $SIMPLE
ruby simple.rb $SIMPLE_P

printf "\nSentinel....\n"
ruby sentinel.rb $SENTINEL
ruby sentinel.rb $SENTINEL_P

printf "\nCluster....\n"
ruby cluster.rb $CLUSTER
ruby cluster.rb $CLUSTER_P

printf "\nSimple TLS....\n"
ruby simple_tls.rb $SIMPLE_TLS
ruby simple_tls.rb $SIMPLE_P_TLS

printf "\nSentinel TLS....\n"
ruby sentinel_tls.rb $SENTINEL_TLS
ruby sentinel_tls.rb $SENTINEL_P_TLS

printf "\nCluster TLS....\n"
ruby cluster_tls.rb $CLUSTER_TLS
ruby cluster_tls.rb $CLUSTER_P_TLS