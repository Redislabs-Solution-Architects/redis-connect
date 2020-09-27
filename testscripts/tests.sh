#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
run() {
     #cd to directory
    cd "$(dirname "${1}")"
    #execute the command
     ./"$(basename "${1}")"
     #move back 
    cd ${DIR} 
}

run ../java/jedis/run.sh
run ../java/lettuce/run.sh
run ../python/redispy/run.sh
run ../dotnet/stackexchange/run.sh
run ../golang/go-redis/run.sh
run ../golang/redigo/run.sh 
run ../cplusplus/redisplusplus/run.sh
#run ../cplusplus/redisplusplus/runtls.sh
run ../node.js/node-redis/run.sh
run ../node.js/ioredis/run.sh
run ../ruby/redis-rb/run.sh
