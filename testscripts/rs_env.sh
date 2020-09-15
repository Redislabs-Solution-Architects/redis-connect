#repo location on local file system
export REPO_LOCATION=root/redisconnect
#RS cluster
export CLUSTER_FQDN="example.demo.redislabs.com"
export CLUSTER_USER="example@redislabs.com"
export CLUSTER_PASSWORD="clusterpassowrd"
#node ip used for cluster and sentinel
export NODE_IP=37.227.88.254
#password for databases
export DB_PASSWORD="mh2Y6FqDRz"
# used for JKS and PFX cert bundles. if changed you will also need to change in sample files
export BUNDLE_PASSWORD="A4TVrVCHg8Ztm" 

export SIMPLE="redis-10001.${CLUSTER_FQDN} 10001"
export SIMPLE_P="redis-10002.${CLUSTER_FQDN} 10002 ${DB_PASSWORD}"
export SENTINEL="${NODE_IP} 8001 simple"
export SENTINEL_P="${NODE_IP} 8001 simple-p ${DB_PASSWORD}"
export CLUSTER="${NODE_IP} 10003"
export CLUSTER_P="${NODE_IP} 10004 ${DB_PASSWORD}"
export SIMPLE_TLS="redis-10005.${CLUSTER_FQDN} 10005"
export SIMPLE_P_TLS="redis-10006.${CLUSTER_FQDN} 10006 ${DB_PASSWORD}"
export SENTINEL_TLS="${NODE_IP} 8001 simple-tls"
export SENTINEL_P_TLS="${NODE_IP} 8001 simple-p-tls ${DB_PASSWORD}"
export CLUSTER_TLS="${NODE_IP} 10007"
export CLUSTER_P_TLS="${NODE_IP} 10008 ${DB_PASSWORD}"
