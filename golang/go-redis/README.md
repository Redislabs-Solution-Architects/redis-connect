 # golang go-redis
* Library: https://github.com/go-redis/redis 
* Library version : v8.0.0-beta.9
* Runtime Version: go 1.14
* RS version: **ToDo**
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | N/C    | N/C     | N/C    | 

* N/A : Not Available
* N/C : Not researched or checked

## Comments
Popular library. This sample is using v8.0.0 which is in beta. 
A [universal client](https://pkg.go.dev/github.com/go-redis/redis/v8?tab=doc#UniversalClient) is also available that depending on config options supports simple, sentinel and cluster

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