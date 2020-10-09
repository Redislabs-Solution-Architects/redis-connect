A collection of samples using different libraries to connect to redis and redis enterprise

For each library have the following connection types
* Simple connection to single endpoint
* Sentinel
* Cluster

# Overview Video
[Overview video available on Google Drive](https://drive.google.com/file/d/1Hnx5aC5nV8ev22vvA2VjrL3GvDNka0Yp/view?usp=sharing)

# Sample Program
In each example
* Connect to Redis
* simple get/set command and show output
* Close connection/connection pool
* In case of sentinel or cluster API , show where more sentinels or nodes can be added



# Coverage
Samples are tested with

| Library                                               | OSS Redis| Redis Enterprise  | Notes               |
| ---------------------------------------------         |:----:    |:---:              |:--------------------|
| [Java Jedis](java/jedis/README.md)                    | Y    | Y   | No TLS sentinel support    | |
| [Java Lettuce](java/lettuce/README.md)                | Y    | Y   |     | |
| [.Net StackExchange](dotnet/stackexchange/README.md)  | Y    | Y   |Sentinel does not work with 2.1.58 for RS use 2.1.30| |
| [Python redispy](python/redispy/README.md)            | Y    | Y   |     | |
| [Node.js ioredis](node.js/ioredis/README.md)          | Y    | Y   |     | |
| [Node.js noderedis](node.js/node-redis/README.md)     | Y    | Y   |     | |
| [golang go-redis](golang/go-redis/README.md)          | Y    | Y   |Sentinel with TLS does not work| |
| [golang redigo](golang/redigo/README.md)              | Y    | Y   |     | |
| [C++ redisplusplus](cplusplus/redisplusplus/README.md)| Y    | Y   |     | |
| [ruby ruby-rb](ruby/redis-rb/README.md)               | Y    | Y   |     | |


# Contribution
* Clone , change , test and commit
* If you find any improvement e.g better language idioms, better way to do things , please change and commit
* If you have tested with a new version of the library, just test, update the readme and commit


# When Adding new Library
* When writing README.md assume user can follow instructions but is not familiar with the language or eco system. [Template](README_lib_template.md) is available
* Use minimal dependencies.
* For  consistency follow the pattern of other samples
* Prefer simplicity over advanced language features
* Single file should execute, have minimal code and, you should be able to share the single file as an example.
* Prefer copy/paste over reuse of code across sample files
* Use connection pooling where the client library supports it. As this is the most common scenario for a production examples
* TLS samples are only tested with RS
* For TLS do the sample for 2-way SSL. If verification hook e.g `verifyhostname` is available provide empty implementation(**discuss**)



# TODO
* Verify certificates or review to provide protection for [MITM](https://www.cs.utexas.edu/~shmat/shmat_ccs12.pdf)
* Example blocking operation if supported
* Pub/Sub
* Add Spring boot sample
