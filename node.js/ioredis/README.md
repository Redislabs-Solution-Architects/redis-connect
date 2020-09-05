
# Node.js ioredis
* Library: https://github.com/luin/ioredis
* Library version : 4.17.3
* Runtime Version: node.js v12.18.3
* RS version: **ToDo**
* OSS Redis: 6.0.6 4/09/2020

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | N/C    | N/C     | N/C    | 

* N/A : Not Available
* N/C : Not researched or checked
## Comments
Well documented , well liked library.

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