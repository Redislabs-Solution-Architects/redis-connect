 # Python redis-py
* Library: [redis-py](https://github.com/andymccurdy/redis-py)
* Library version : 3.5.3
* Library version: Python 3.7.3
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y*     |
| TLS | Y      | Y       | Y*     |
* N/A : Not Available
* N/C : Not researched or checked

## Comments/Gotchas
* Cluster API supported by a separate [extension](https://github.com/Grokzen/redis-py-cluster) to library
* Sentinel with TLS requires a [workaround](https://github.com/andymccurdy/redis-py/issues/1306)
* ToDo: find way to verify ip address manually for Cluster/Sentinel TLS

## Prerequisite
Install [Python3](https://www.python.org/downloads/) for your platform

## Setup
Make sure you are in redispy directory and create virtual environment and activate it
```bash
 python3 -m venv venv
 . venv/bin/activate
```

Install the dependencies
```bash
 pip install -r requirements.txt
 ```
## Run
Password is optional for all samples

### Simple
Start Redis instance.
```bash
python simple.py redishost port password
```

### SimpleTLS
```bash
python simpletls.py redishost port password
```

### Sentinel
```bash
python sentinel.py sentinelhost port service password
```

### SentinelTLS
```bash
python sentineltls.py sentinelhost port service password
```

### Cluster
Redis-py does not support cluster API. This sample uses an extension to redis-py. https://github.com/Grokzen/redis-py-cluster. 
Note that redis-cluster does not support the latest version of redis-py

deactivate previous venv by running `deactivate` and cd to **cluster**
```bash
 python3 -m venv venv
 . venv/bin/activate
```
Install the dependencies
```bash
pip install -r requirements.txt
 ```
#### Cluster(normal)
```bash
python cluster.py node1 port password
```

#### Cluster TLS
```bash
python clustertls.py node1 port password
```
