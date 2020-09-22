#!/bin/bash
set -x 
#Jedis
cd $REPO_LOCATION/java/jedis
./mvnw clean package
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple $SIMPLE
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple $SIMPLE_P
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel $SENTINEL
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel $SENTINEL_P
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster $CLUSTER
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster $CLUSTER_P
java -cp ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.debug=ssl \
    com.rl.sample.jedis.SimpleTLS $SIMPLE_TLS
java -cp ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.debug=ssl \
    com.rl.sample.jedis.SimpleTLS $SIMPLE_P_TLS
java -cp ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.debug=ssl \
    com.rl.sample.jedis.ClusterTLS $CLUSTER_TLS
java -cp ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.debug=ssl \
    com.rl.sample.jedis.ClusterTLS $CLUSTER_P_TLS

#Lettuce
cd $REPO_LOCATION/java/lettuce
./mvnw clean package
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple $SIMPLE
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple $SIMPLE_P
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel $SENTINEL
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel $SENTINEL_P
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster $CLUSTER
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster $CLUSTER_P

#python redis-py
cd $REPO_LOCATION/python/redispy
. venv/bin/activate
python simple.py $SIMPLE
python simple.py $SIMPLE_P
python sentinel.py $SENTINEL
python sentinel.py $SENTINEL_P
python simpletls.py $SIMPLE_TLS
python simpletls.py $SIMPLE_P_TLS
python sentineltls.py $SENTINEL_TLS
python sentineltls.py $SENTINEL_P_TLS
deactivate
cd cluster
. venv/bin/activate
python cluster.py $CLUSTER
python cluster.py $CLUSTER_P
python clustertls.py $CLUSTER_TLS
python clustertls.py $CLUSTER_P_TLS
deactivate


#dotnet stackexchange
cd $REPO_LOCATION/dotnet/stackexchange/simple
dotnet build
dotnet run $SIMPLE
dotnet run $SIMPLE_P
dotnet run $CLUSTER
dotnet run $CLUSTER_P

cd $REPO_LOCATION/dotnet/stackexchange/sentinel
dotnet build
dotnet run $SENTINEL
dotnet run $SENTINEL_P

cd $REPO_LOCATION/dotnet/stackexchange/simpletls
dotnet build
dotnet run $SIMPLE_TLS
dotnet run $SIMPLE_P_TLS
dotnet run $CLUSTER_TLS
dotnet run $CLUSTER_P_TLS

cd $REPO_LOCATION/dotnet/stackexchange/sentineltls
dotnet build
dotnet run $SENTINEL_TLS
dotnet run $SENTINEL_P_TLS



#goloang go-redis
cd $REPO_LOCATION/golang/go-redis/simple
go build
./simple $SIMPLE
./simple $SIMPLE_P

cd $REPO_LOCATION/golang/go-redis/sentinel
go build
./sentinel $SENTINEL
./sentinel $SENTINEL_P

cd $REPO_LOCATION/golang/go-redis/cluster
go build
./cluster $CLUSTER
./cluster $CLUSTER_P

#goland redigo
cd $REPO_LOCATION/golang/redigo/simple
go build
./simple $SIMPLE
./simple $SIMPLE_P
cd $REPO_LOCATION/golang/redigo/sentinel
go build
./sentinel $SENTINEL
./sentinel $SENTINEL_P
cd $REPO_LOCATION/golang/redigo/cluster
go build
./cluster $CLUSTER
./cluster $CLUSTER_P

#node.js ioredis
cd $REPO_LOCATION/node.js/ioredis
npm install
node simple.js $SIMPLE
node simple.js $SIMPLE_P
node sentinel.js $SENTINEL
node sentinel.js $SENTINEL_P
node cluster.js $CLUSTER
node cluster.js $CLUSTER_P

#nodejs node-redis
cd $REPO_LOCATION/node.js/node-redis
npm install
node simple.js $SIMPLE
node simple.js $SIMPLE_P

#C++ redisplusplus
cd $REPO_LOCATION/cplusplus/redisplusplus
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
g++ -std=c++11 -o simple  simple.cpp -lredis++ -lhiredis -pthread
./simple $SIMPLE
./simple $SIMPLE_P
g++ -std=c++11 -o sentinel  sentinel.cpp -lredis++ -lhiredis -pthread
./sentinel $SENTINEL
./sentinel $SENTINEL_P
g++ -std=c++11 -o cluster  cluster.cpp -lredis++ -lhiredis -pthread
./cluster $CLUSTER
./cluster $CLUSTER_P

#ruby redis-rb
cd $REPO_LOCATION/ruby/redis-rb
ruby simple.rb $SIMPLE
ruby simple.rb $SIMPLE_P
ruby sentinel.rb $SENTINEL
ruby sentinel.rb $SENTINEL_P
ruby cluster.rb $CLUSTER
ruby cluster.rb $CLUSTER_P

cd $REPO_LOCATION/testscripts
set +x
