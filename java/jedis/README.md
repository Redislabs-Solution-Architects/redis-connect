 # Java Jedis 
* Library: Jedis https://github.com/xetorthio/jedis
* Library version : 3.3.0
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
Simple fast library, documentation can be struggle 

## Prerequisite
Install Java JDK https://openjdk.java.net/install/index.html

## Setup
cd to jedis directory
```
./mvnw clean package
```

## Run
Password is optional for all samples

### Simple
```
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple host port password
```

### Sentinel 
```
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel  host port service password
```

### Cluster
```
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster  host port password
```