 # Ruby redis-rb
* Library: [redis-rb](https://github.com/redis/redis-rb)
* Library version : 4.2.2
* Runtime Version: 2.7.1
* RS version: 6.0.8-32
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y      | Y       | Y      |

* N/A : Not Available
* N/C : Not researched or checked
## Comments/ToDO
Main ruby library. Excellent examples.
ToDo: Add hook to verify IP's manually for sentinel/cluster TLS

## Prerequisite
Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
On MacOS you need root permission to install gems if when using Apple bundled ruby. It is easier to install ruby using above link.

## Setup
`cd ruby/redis-rb` and run `bundle` to install the gem
## Run
Password is optional for all samples

### Simple
`ruby simple.rb host port password`

### Sentinel
`ruby sentinel.rb sentinelhost sentinelport service password`

### Cluster
`ruby cluster.rb host port password`

### Simple TLS
`ruby simpleTLS.rb host port password`

### Sentinel TLS
`ruby sentinelTLS.rb sentinelhost sentinelport service password`

### Cluster TLS
`ruby clusterTLS.rb host port password`
