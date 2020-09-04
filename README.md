A collection of samples using different libraries to connect to redis

* When writing readme assume user can follow instructions but is not familiar with the language
* Use minimal dependencies. 
* Prefer simplicity over advanced language features
* Single file should execute, have minimal code and  should be able to share the single file as an example.
* Prefer copy/paste over reuse across sample files
* Use connection pooling where the library supports it. As this is the most common scenario for a production examples 

For each library have the samples for following with and without TLS
* Simple connection to single endpoint
* Sentinel
* Cluster

In each example
* Connect to Redis
* simple get/set
* Close connection/connection pool
* In case of sentinel or cluster API , show where more sentinels or hosts can be added


# Coverage


| Library               | Redis| RS  | Notes               |
| --------------------- |:----:|:---:|:-------------------:|
| Java Jedis            | Y    | N   |     | |
| Java Lettuce          | Y    | N   |     | |
|.Net StackExchange     | Y    | N   |     | |
| Python redis          | Y    | N   |     | |
| JS ironredis          | Y    | N   |     | |
| JS noderedis          | Y    | N   |     | |
| golang go-redis       | Y    | N   |     | |
| golang redigo         | Y    | N   |     | |
| C++ redisplusplus     | Y    | N   |     | |







Note these are getting started samples, different libraries support multiple programming styles

## TODO
Show 
* blocking operation
* pub/sub

Samples for TLS configuration