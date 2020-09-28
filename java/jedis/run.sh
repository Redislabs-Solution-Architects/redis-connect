#!/bin/bash

echo "                 #                        "
echo "                 # ###### #####  #  ####  "
echo "                 # #      #    # # #      "
echo "                 # #####  #    # #  ####  "
echo "           #     # #      #    # #      # "
echo "           #     # #      #    # # #    # "
echo "            #####  ###### #####  #  ####  "
echo "                                          "
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh
${DIR}/mvnw clean package
java -cp  ${DIR}//target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple $SIMPLE
java -cp  ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple $SIMPLE_P
java -cp  ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel $SENTINEL
java -cp  ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel $SENTINEL_P
java -cp  ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster $CLUSTER
java -cp  ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster $CLUSTER_P
java -cp  ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=${DIR}/../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=${DIR}/../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    com.rl.sample.jedis.SimpleTLS $SIMPLE_TLS
java -cp ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=${DIR}/../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=${DIR}/../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    com.rl.sample.jedis.SimpleTLS $SIMPLE_P_TLS
java -cp ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=${DIR}/../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=${DIR}/../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    com.rl.sample.jedis.ClusterTLS $CLUSTER_TLS
java -cp ${DIR}/target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=${DIR}/../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=${DIR}/../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    com.rl.sample.jedis.ClusterTLS $CLUSTER_P_TLS