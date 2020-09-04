
Build
./mvnw clean package


Simple
```
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Simple 127.0.0.1 9000
```

Sentinel
```
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Sentinel 127.0.0.1 5001  mymaster
```

Cluster
```
java -cp target/lettucesample-1.0-SNAPSHOT-jar-with-dependencies.jar com.rl.sample.lettuce.Cluster 127.0.0.1 7000
```