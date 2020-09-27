#!/bin/bash
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