
# Java Lettuce 
* Library: Lettuce https://github.com/lettuce-io/lettuce-core
* Library version : 5.3.3.RELEASE
* Runtime Version: JDK 12
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y      | Y       | Y      | 

* N/A : Not Available
* N/C : Not researched or checked
## Comments
* Popular library, defaults for Spring. Good documentation
* For TLS could not find hook for custom host name verifier. Had to disable host verification for sentinel and cluster

## Prerequisite
Install Java JDK https://openjdk.java.net/install/index.html

## Setup
cd to lettuce directory
```
./mvnw clean package
```

## Run
Password is optional for all samples

### Simple
```
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple host port password
```

### Sentinel 
```
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel sentinelhost port  service password
```

### Cluster
```
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster node port password 
```
### For TLS change the location of trust store and key store in code. 

### Simple TLS
```
java -cp ./target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SimpleTLS host port password
```
### Sentinel TLS
```
java -cp ./target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SentinelTLS sentinelhost port  service password
```
### Cluster TLS
```
java -cp ./target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.ClusterTLS node port password
```