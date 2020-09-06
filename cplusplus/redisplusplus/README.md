# Name  redis-plus-plus
* Library: https://github.com/sewenew/redis-plus-plus
* Library version : master branch
* Runtime Version: C++ 11 / C++ 17
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | N/C    | N/C     | N/C   | 

* N/A : Not Available
* N/C : Not researched or checked
## Comments
Excellent documentation and examples. A C++ wrapper around hiredis

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