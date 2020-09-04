# Prerequistes

JDK installed latest version

# Build

```
./mvnw clean package
```

# Run
## Simple
```
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Simple 127.0.0.1 9000
```

## Sentinel
```
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Sentinel  127.0.0.1 5003 mymaster
```
## Cluster
```
java -cp  ./target/jedissample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.jedis.Cluster  127.0.0.1 7000
```