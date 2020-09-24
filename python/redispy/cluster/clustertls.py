import rediscluster
import sys


def main():
    if not (len(sys.argv) == 3 or len(sys.argv) == 4):
        print("Usage: host port password")
        exit(1)
    host = sys.argv[1]
    port = sys.argv[2]
    password = None
    if len(sys.argv) == 4:
        password = sys.argv[3]

    # Add more nodes here to the list
    startup_nodes = [{"host": host, "port": port}]
    rc = rediscluster.RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        password=password,
        ssl=True,
        ssl_keyfile="../../../testscripts/tls/db_key.pem",
        ssl_certfile="../../../testscripts/tls/db_cert.pem",
        ssl_cert_reqs="required",
        ssl_ca_certs="../../../testscripts/tls/ca_cert.pem",
        #ssl_check_hostname=False, This option is not supported yet
    )
    print("Connected to Redis")
    print("Set: {}".format(rc.set("foo", "bar")))
    print("Get: {}".format(rc.get("foo")))


if __name__ == "__main__":
    main()
