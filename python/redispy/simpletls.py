import redis
import sys
from pathlib import Path


def main():
    if not (len(sys.argv) == 3 or len(sys.argv) == 4):
        print("Usage: host port password")
        exit(1)
    host = sys.argv[1]
    port = sys.argv[2]
    password = None
    if len(sys.argv) == 4:
        password = sys.argv[3]

    r = redis.StrictRedis(
        host=host,
        port=port,
        password=password,
        ssl=True,
        ssl_keyfile="../../testscripts/tls/db_key.pem",
        ssl_certfile="../../testscripts/tls/db_cert.pem",
        ssl_cert_reqs="required",
        ssl_ca_certs="../../testscripts/tls/ca_cert.pem",
    )
    print("Connected to Redis")

    print("Set: {}".format(r.set("foo", "bar")))
    print("Get: {}".format(r.get("foo")))

    r.connection_pool.disconnect()


if __name__ == "__main__":
    main()
