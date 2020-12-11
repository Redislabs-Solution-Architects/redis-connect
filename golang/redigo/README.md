# golang redigo
* Library: [redigo](https://github.com/gomodule/redigo)
* Library version : v2.0.0
* Runtime Version: go 1.14
* RS version: 6.0.8-32
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | N*      | N*     |
| TLS | Y      | N/C     | N/C    |

> *Sentinel and cluster are supported by 2 extensions that seem to be abandoned. Samples here are just for completeness

* N/A : Not Available
* N/C : Not researched or checked

## Comments
Popular library for simple connection. Cluster and sentinel extensions are abandoned


## Prerequisite
Install [golang](https://golang.org/doc/install)

## Setup
use `go build` to build each sample

## Run
Password is optional for all samples

### Simple
cd redigo/simple

```bash
go build
./simple host port password
```

### Simple TLS
cd redigo/simpletls

```bash
go build
./simpletls host port password
```

### Sentinel (Caution)
Uses [abandoned extension](https://github.com/FZambia/sentinel)

cd redigo/sentinel

```bash
go build
./sentinel sentinelhost sentinelport service password
```

### Cluster(Caution)
Uses [PR](https://github.com/wuxibin89/redis-go-cluster/pull/31) for [abandoned extension](https://github.com/wuxibin89/redis-go-cluster) for password support

cd redigo/cluster

```bash
go build
./cluster host port password
```