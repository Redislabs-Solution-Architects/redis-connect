
# Java Lettuce 
* Library: [Lettuce](https://github.com/lettuce-io/lettuce-core)
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
* Lettuce has 3 different APIs: sync, async, and reactive
** Sync should be used for simple interactions (typically http request/response with low concurrency)
** Async should be used in conjunction with connection pooling for high-throughput use cases (batch jobs). [Lettuce Connection Pooling](https://github.com/lettuce-io/lettuce-core/wiki/Connection-Pooling#connection-pool-support)
** Reactive should be used by mature development teams that already have some reactive programming experience (reactive web framework to reactive redis)

## Prerequisite
Install [Java JDK](https://openjdk.java.net/install/index.html)

## Setup
cd to lettuce directory
```bash
./mvnw clean package
```

## Run
Password is optional for all samples

### Simple
```bash
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple host port password
```

### Sentinel
```bash
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel sentinelhost port  service password
```

### Cluster
```bash
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster node port password 
```
### For TLS change the location of trust store and key store in code. 

### Simple TLS
```bash
java -cp ./target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SimpleTLS host port password
```
### Sentinel TLS
```bash
java -cp ./target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.SentinelTLS sentinelhost port  service password
```
### Cluster TLS
```bash
java -cp ./target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.ClusterTLS node port password
```
