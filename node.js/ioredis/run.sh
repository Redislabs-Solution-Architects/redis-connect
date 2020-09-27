DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

npm install
node simple.js $SIMPLE
node simple.js $SIMPLE_P
node sentinel.js $SENTINEL
node sentinel.js $SENTINEL_P
node cluster.js $CLUSTER
node cluster.js $CLUSTER_P