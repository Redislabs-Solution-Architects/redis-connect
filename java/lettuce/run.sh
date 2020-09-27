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
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple $SIMPLE
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple $SIMPLE_P
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel $SENTINEL
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel $SENTINEL_P
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster $CLUSTER
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster $CLUSTER_P
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SimpleTLS $SIMPLE_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SimpleTLS $SIMPLE_P_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SentinelTLS $SENTINEL_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SentinelTLS $SENTINEL_P_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.ClusterTLS $CLUSTER_TLS
java -cp ${DIR}/target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.ClusterTLS $CLUSTER_P_TLS