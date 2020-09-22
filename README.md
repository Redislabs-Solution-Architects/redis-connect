A collection of samples using different libraries to connect to redis and redis enterprise

For each library have the following connection types
* Simple connection to single endpoint
* Sentinel
* Cluster

# Sample Program 
In each example
* Connect to Redis
* simple get/set command and show output
* Close connection/connection pool
* In case of sentinel or cluster API , show where more sentinels or nodes can be added



# Coverage
Samples are tested with

| Library                                               | OSS Redis| Redis Enterprise  | Notes               |
| ---------------------------------------------         |:----:|:---:|:--------------------|
| [Java Jedis](java/jedis/README.md)                    | Y    | Y   | No TLS sentinel support    | |
| [Java Lettuce](java/lettuce/README.md)                | Y    | Y   |     | |
| [.Net StackExchange](dotnet/stackexchange/README.md)  | Y    | Y   |Sentinel does not work with 2.1.58 for RS use 2.1.30| |
| [Python redispy](python/redispy/README.md)            | Y    | Y   |     | |
| [Node.js ioredis](node.js/ioredis/README.md)          | Y    | Y   |     | |
| [Node.js noderedis](node.js/node-redis/README.md)     | Y    | Y   |     | |
| [golang go-redis](golang/go-redis/README.md)          | Y    | Y   |Sentinel for a db with password does not work| |
| [golang redigo](golang/redigo/README.md)              | Y    | Y   |     | |
| [C++ redisplusplus](cplusplus/redisplusplus/README.md)| Y    | Y   |     | |
| [ruby ruby-rb](ruby/redis-rb/README.md)               | Y    | N   |     | |


# Assumptions
* When writing readme.md assume user can follow instructions but is not familiar with the language or eco system
* Use minimal dependencies. 
* Prefer simplicity over advanced language features
* Single file should execute, have minimal code and, should be able to share the single file as an example.
* Prefer copy/paste over reuse of code across sample files
* Use connection pooling where the library supports it. As this is the most common scenario for a production examples 
* TLS samples are only tested with RS


# TODO
* Samples for TLS (2 way)
* Example blocking operation if supported
* Pub/Sub
* Add Spring boot sample