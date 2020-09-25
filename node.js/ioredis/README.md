
# Node.js ioredis
* Library: https://github.com/luin/ioredis
* Library version : 4.18
* Runtime Version: node.js v12.18.3
* RS version: 6.0.6-35
* OSS Redis: 6.0.6 

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y*     | Y*      | N/C    | 

* N/A : Not Available
* N/C : Not researched or checked
## Comments/Gotchas
* Well documented , well liked library.
* TLS support is extremely fragile. SimpleTLS on connection close throws and exception. 4.17.3 sentinel TLS and cluster TLS were not working. In 4.18.0 sentinel TLS works , cluster TLS still does not work.



## Prerequisite
Download and install Node.js https://nodejs.org/en/download/ 

## Setup
`cd node.js/ioredis` and  Install the packages
```
npm install
```

## Run
Password is optional for all samples

### Simple
`node simple.js host port password`


### Sentinel
`node sentinel.js sentinelhost sentinelport service password`


### Cluster
`node cluster.js host port password`
