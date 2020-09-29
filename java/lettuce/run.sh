#!/bin/bash

echo '       _             _          _          _      _                   _             _       '
echo '        _\ \          /\ \       /\ \       /\ \   /\_\               /\ \           /\ \   ' 
echo '       /\__ \        /  \ \      \_\ \      \_\ \ / / /         _    /  \ \         /  \ \  ' 
echo '      / /_ \_\      / /\ \ \     /\__ \     /\__ \\ \ \__      /\_\ / /\ \ \       / /\ \ \ ' 
echo '     / / /\/_/     / / /\ \_\   / /_ \ \   / /_ \ \\ \___\    / / // / /\ \ \     / / /\ \_\' 
echo '    / / /         / /_/_ \/_/  / / /\ \ \ / / /\ \ \\__  /   / / // / /  \ \_\   / /_/_ \/_/' 
echo '   / / /         / /____/\    / / /  \/_// / /  \/_// / /   / / // / /    \/_/  / /____/\   ' 
echo '  / / / ____    / /\____\/   / / /      / / /      / / /   / / // / /          / /\____\/   ' 
echo ' / /_/_/ ___/\ / / /______  / / /      / / /      / / /___/ / // / /________  / / /______   ' 
echo '/_______/\__\// / /_______\/_/ /      /_/ /      / / /____\/ // / /_________\/ / /_______\  ' 
echo '\_______\/    \/__________/\_\/       \_\/       \/_________/ \/____________/\/__________/  ' 
echo '                                                                                            ' 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

${DIR}/mvnw clean package

printf "\nSimple....\n"
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple $SIMPLE
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple $SIMPLE_P

printf "\nSentinel....\n"
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel $SENTINEL
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel $SENTINEL_P

printf "\nCluster....\n"
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster $CLUSTER
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster $CLUSTER_P

printf "\nSimple TLS....\n"
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SimpleTLS $SIMPLE_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SimpleTLS $SIMPLE_P_TLS

printf "\nSentinel TLS....\n"
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SentinelTLS $SENTINEL_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SentinelTLS $SENTINEL_P_TLS

printf "\nCluster TLS....\n"
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.ClusterTLS $CLUSTER_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.ClusterTLS $CLUSTER_P_TLS