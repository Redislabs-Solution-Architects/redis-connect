 # Java Jedis 
* Library: [Jedis](https://github.com/xetorthio/jedis)
* Library version : 3.3.0
* Runtime Version: JDK 12
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y      | N/A     | Y      |

* N/A : Not Available
* N/C : Not researched or checked

## Comments/Gotchas
* Simple fast library, documentation can be struggle see [tests](https://github.com/xetorthio/jedis/tree/master/src/test/java/redis/clients/jedis/tests)
* Does not support TLS with Sentinel. see [PR](https://github.com/xetorthio/jedis/pull/2024)
* A more comprehensive example from Julien is available in SA [repo](https://github.com/Redislabs-Solution-Architects/redconn)


## Prerequisite
Install [Java JDK](https://openjdk.java.net/install/index.html
)
## Setup
cd to jedis directory
```bash
./mvnw clean package
```

## Run
Password is optional for all samples

### Simple
```bash
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple host port password
```

### Sentinel
```bash
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel  host port service password
```

### Cluster
```bash
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster  host port password
```

### Simple TLS
```bash
java -cp ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.debug=ssl \
    com.rl.sample.jedis.SimpleTLS host port password
```

### Cluster TLS
```bash
java -cp ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar \
    -Djavax.net.ssl.keyStoreType=pkcs12 \
    -Djavax.net.ssl.keyStore=../../testscripts/tls/db_cert.pfx \
    -Djavax.net.ssl.keyStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.ssl.trustStoreType=jks \
    -Djavax.net.ssl.trustStore=../../testscripts/tls/sample_ca_truststore.jks \
    -Djavax.net.ssl.trustStorePassword=${BUNDLE_PASSWORD} \
    -Djavax.net.debug=ssl \
    com.rl.sample.jedis.ClusterTLS host port password
 ```