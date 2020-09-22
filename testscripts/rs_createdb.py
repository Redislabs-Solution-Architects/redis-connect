import urllib3
import os
import requests
import json
from requests.auth import HTTPBasicAuth

urllib3.disable_warnings()  # is this bad?
CLUSTER_FQDN = os.environ.get("CLUSTER_FQDN")
print(CLUSTER_FQDN)
if not CLUSTER_FQDN:
    print("CLUSTER_FQDN variable not set")
    exit(1)

CLUSTER_USER = os.environ.get("CLUSTER_USER")
print(CLUSTER_USER)
if not CLUSTER_USER:
    print("CLUSTER_USER variable not set")
    exit(1)

CLUSTER_PASSWORD = os.environ.get("CLUSTER_PASSWORD")
if not CLUSTER_USER:
    print("CLUSTER_PASSWORD variable not set")
    exit(1)

DB_PASSWORD = os.environ.get("DB_PASSWORD")
if not DB_PASSWORD:
    print("DB_PASSWORD variable not set")
    exit(1)

# Using python as bash script gets complex with certificates
def create_db(data):
    return requests.post(
        url="https://" + CLUSTER_FQDN + ":9443/v1/bdbs",
        auth=HTTPBasicAuth(CLUSTER_USER, CLUSTER_PASSWORD),
        headers={
            "Content-Type": "application/json",
        },
        data=json.dumps(data),
        verify=False,
    )


def add_certs(req, public_file):
    with open(public_file, "r") as file:
        pub_cert = file.read()
    req["authentication_ssl_client_certs"] = [{"client_cert": pub_cert}]


def main():

    print("\n\n++ SIMPLE HA 4 shard 10001\n")
    req = {
        "name": "simple",
        "port": 10001,
        "type": "redis",
        "sharding": True,
        "shards_count": 2,
        "replication": True,
        "memory_size": 1073741824,
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
    }
    print(create_db(req).content)

    print("\n\n++ SIMPLEP HA 4 shard with password 10002\n")
    req = {
        "name": "simple-p",
        "port": 10002,
        "type": "redis",
        "sharding": True,
        "shards_count": 2,
        "replication": True,
        "memory_size": 1073741824,
        "authentication_redis_pass": DB_PASSWORD,
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
    }
    print(create_db(req).content)

    print("\n\n++CLUSTER HA 6 shard with OSS cluster 10003\n")
    req = {
        "name": "cluster",
        "port": 10003,
        "type": "redis",
        "sharding": True,
        "shards_count": 3,
        "replication": True,
        "memory_size": 1073741824,
        "oss_cluster": True,
        "proxy_policy": "all-master-shards",
        "oss_cluster_api_preferred_ip_type": "external",
        "shards_placement": "sparse",
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
    }
    print(create_db(req).content)

    print("\n\n++ CLUSTERP HA 6 shard with OSS cluster with password 10004\n")
    req = {
        "name": "cluster-p",
        "port": 10004,
        "type": "redis",
        "sharding": True,
        "shards_count": 3,
        "replication": True,
        "memory_size": 1073741824,
        "oss_cluster": True,
        "proxy_policy": "all-master-shards",
        "oss_cluster_api_preferred_ip_type": "external",
        "shards_placement": "sparse",
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
        "authentication_redis_pass": DB_PASSWORD,
    }
    print(create_db(req).content)

    print("\n\n++ SIMPLETLS HA 4 shard with mTLS 10005\n")
    req = {
        "name": "simple-tls",
        "port": 10005,
        "type": "redis",
        "sharding": True,
        "shards_count": 2,
        "replication": True,
        "memory_size": 1073741824,
        "ssl": True,
        "tls_mode": "enabled",
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
    }
    add_certs(req, "tls/db_cert.pem")
    print(create_db(req).content)

    print("\n\n++ SIMPLEPTLS HA 4 shard with password with mTLS 10006\n")
    req = {
        "name": "simple-p-tls",
        "port": 10006,
        "type": "redis",
        "sharding": True,
        "shards_count": 2,
        "replication": True,
        "memory_size": 1073741824,
        "authentication_redis_pass": DB_PASSWORD,
        "ssl": True,
        "tls_mode": "enabled",
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
    }
    add_certs(req, "tls/db_cert.pem")
    print(create_db(req).content)

    print("\n\n++ CLUSTERTLS HA 6 shard with OSS cluster with mTLS 10007\n")
    req = {
        "name": "cluster-tls",
        "port": 10007,
        "type": "redis",
        "sharding": True,
        "shards_count": 3,
        "replication": True,
        "memory_size": 1073741824,
        "oss_cluster": True,
        "proxy_policy": "all-master-shards",
        "oss_cluster_api_preferred_ip_type": "external",
        "shards_placement": "sparse",
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
        "ssl": True,
        "tls_mode": "enabled",
    }
    add_certs(req, "tls/db_cert.pem")
    print(create_db(req).content)

    print("\n\n++ CLUSTER_P_TLS HA 6 shard with OSS cluster with password with TLS 10008\n")
    req = {
        "name": "cluster-p-tls",
        "port": 10008,
        "type": "redis",
        "sharding": True,
        "shards_count": 3,
        "replication": True,
        "memory_size": 1073741824,
        "oss_cluster": True,
        "proxy_policy": "all-master-shards",
        "oss_cluster_api_preferred_ip_type": "external",
        "shards_placement": "sparse",
        "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"}, {"regex": "(?<tag>.*)"}],
        "authentication_redis_pass": DB_PASSWORD,
        "ssl": True,
        "tls_mode": "enabled",
    }
    add_certs(req, "tls/db_cert.pem")
    print(create_db(req).content)


if __name__ == "__main__":
    main()
