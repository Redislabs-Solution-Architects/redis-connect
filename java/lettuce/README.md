
# Java Lettuce 
* Library: Lettuce https://github.com/lettuce-io/lettuce-core
* Library version : 5.3.3.RELEASE
* Runtime Version: JDK 12
* RS version: **ToDo**
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | N/C    | N/C     | N/C    | 

* N/A : Not Available
* N/C : Not researched or checked
## Comments
Popular library, defaults for Spring. Good documentation 

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
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster host port password 
```