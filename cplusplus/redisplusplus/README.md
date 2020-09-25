# Name  redis-plus-plus
* Library: https://github.com/sewenew/redis-plus-plus
* Library version : redis-plus-plus 1.2/hiredis 1.0
* Runtime Version: C++ 11 / C++ 17
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y      | Y       | Y      | 

* N/A : Not Available
* N/C : Not researched or checked
## Comments/Gotchas
* Excellent documentation and examples. A C++ wrapper around hiredis
* TLS samples are only tested on Ubuntu 16.04.6 LTS. Could not make them work on OS X
* For cluster mode could not find a way to provide multiple nodes 
* Does not support TLS when connecting to Sentinel/Discovery Service . The redis database still can have 2 way SSL
* TLS does not have option for hostname verification 

## Prerequisite
C++ dev environment 

## Setup
Install C++ tools and development environment. Follow the instructions [here](https://github.com/sewenew/redis-plus-plus?undefined#installation) to install hiredis and redis-plus-plus. On *nixes remember to set `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib` in shell before executing binary.

## Run
Password is optional for all samples. Assuming headers and libraries during setup were installed at default locations.

### Simple
Compile
```
g++ -std=c++11 -o simple  simple.cpp -lredis++ -lhiredis -pthread
```
Run
```
./simple host port password
```
### Sentinel 
Compile
```
g++ -std=c++11 -o sentinel  sentinel.cpp -lredis++ -lhiredis -pthread
```
Run
```
./sentinel sentinelhost sentinelport service password
```

### Cluster
Compile
```
g++ -std=c++11 -o cluster  cluster.cpp -lredis++ -lhiredis -pthread
```
Run
```
./cluster host port password
```

## TLS
TLS setup compile is more involved. You will need to compile hireds and redisplusplus with [TLS flags enabled](https://github.com/sewenew/redis-plus-plus?undefined#tlsssl-support).

Additionally when compiling with shared libraries you will need to add `-lhiredis_ssl` for linking even for non TLS samples.


### Simple TLS
Compile
```
g++ -std=c++11 -o simpletls  simpletls.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
```
Run
```
./simpletls ./host port password
```

### Sentinel TLS
Compile
```
g++ -std=c++11 -o sentineltls  sentineltls.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
```
Run
```
./sentineltls sentinelhost sentinelport service password
```

### Cluster TLS
Compile
```
g++ -std=c++11 -o clustertls  clustertls.cpp -lredis++ -lhiredis -lhiredis_ssl -pthread
```
Run
```
./clustertls host port password
```


