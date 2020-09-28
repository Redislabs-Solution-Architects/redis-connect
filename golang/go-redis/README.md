 # golang go-redis
* Library: https://github.com/go-redis/redis 
* Library version : v8.2.2
* Runtime Version: go 1.14
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y      | N*      | Y      | 

* N/A : Not Available
* N/C : Not researched or checked


## Comments/Gotchas
* Popular library. 
* Sentinel with TLS does not work , sample is provided but seems to be a bug where `tls.config` is not passed when connecting to master. and following error is shown `ERR unencrypted connection is prohibited`
* A [universal client](https://pkg.go.dev/github.com/go-redis/redis/v8?tab=doc#UniversalClient) is also available that depending on config options supports simple, sentinel and cluster

## Prerequisite
Install golang https://golang.org/doc/install

## Setup
use `go build` to build each sample

## Run
Password is optional for all samples

### Simple
cd go-redis/simple

```
go build
./simple host port password
``` 

### Sentinel 
cd go-redis/sentinel

```
go build
./sentinel sentinelhost sentinelport service password
``` 

### Cluster
cd go-redis/cluster

```
go build
./cluster host port password
``` 

### Simple TLS
cd go-redis/simpletls

```
go build
./simpletls host port password
``` 


### Cluster TLS
cd go-redis/clustertls

```
go build
./clustertls host port password
``` 