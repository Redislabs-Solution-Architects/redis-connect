# golang redigo
* Library: https://github.com/gomodule/redigo
* Library version : v1.8.2
* Runtime Version: go 1.14
* RS version: **ToDo**
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | N*      | N*     |
| TLS | N/C    | N/C     | N/C    | 

> *Sentinel and cluster are supported by 2 extensions that seem to be abandoned. Samples here are just for completeness

* N/A : Not Available
* N/C : Not researched or checked

## Comments
Popular library for simple connection. Cluster and sentinel extensions are abandoned


## Prerequisite
Install golang https://golang.org/doc/install

## Setup
use `go build` to build each sample

## Run
Password is optional for all samples

### Simple
cd redigo/simple

```
go build
./simple host port password
``` 

### Sentinel (caution)
Uses abandoned extension https://github.com/FZambia/sentinel 

cd redigo/sentinel

```
go build
./sentinel sentinelhost sentinelport service password
``` 

### Cluster(caution)
Uses [PR](https://github.com/wuxibin89/redis-go-cluster/pull/31) for abandoned extension for password support https://github.com/wuxibin89/redis-go-cluster 

cd redigo/cluster

```
go build
./cluster host port password
``` 
