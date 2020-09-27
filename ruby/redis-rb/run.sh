DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

bundle
ruby simple.rb $SIMPLE
ruby simple.rb $SIMPLE_P
ruby sentinel.rb $SENTINEL
ruby sentinel.rb $SENTINEL_P
ruby cluster.rb $CLUSTER
ruby cluster.rb $CLUSTER_P
ruby simpleTLS.rb $SIMPLE_TLS
ruby simpleTLS.rb $SIMPLE_P_TLS
ruby sentinelTLS.rb $SENTINEL_TLS
ruby sentinelTLS.rb $SENTINEL_P_TLS
ruby clusterTLS.rb $CLUSTER_TLS
ruby clusterTLS.rb $CLUSTER_P_TLS