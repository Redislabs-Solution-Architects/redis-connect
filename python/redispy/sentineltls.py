import redis
import redis.sentinel
import sys

# using workaround from https://github.com/andymccurdy/redis-py/issues/1306
class SSLSentinelManagedConnection(
    redis.sentinel.SentinelManagedConnection, redis.SSLConnection
):
    def __init__(self, **kwargs):
        self.connection_pool = kwargs.pop(
            "connection_pool"
        )  # replicate the init code from SentinelManagedConnection
        redis.SSLConnection.__init__(
            self, **kwargs
        )  # we cannot use super() here because it is not first in the MRO


def main():
    if not (len(sys.argv) == 4 or len(sys.argv) == 5):
        print("Usage: sentinelhost sentinelport service password")
        exit(1)
    sentinel_host = sys.argv[1]
    sentinel_port = sys.argv[2]
    service_name = sys.argv[3]

    password = None
    if len(sys.argv) == 5:
        password = sys.argv[4]

    # you can add more sentinels to the list
    sentinel_list = [(sentinel_host, sentinel_port)]
    s = redis.sentinel.Sentinel(
        sentinel_list,
        sentinel_kwargs={"ssl": True, "ssl_cert_reqs": None},
        **{
            "connection_class": SSLSentinelManagedConnection,
            "password": password,
            "ssl_keyfile": "../../testscripts/tls/db_key.pem",
            "ssl_certfile": "../../testscripts/tls/db_cert.pem",
            "ssl_cert_reqs": "required",
            "ssl_ca_certs": "../../testscripts/tls/ca_cert.pem",
        }
    )
    r = s.master_for(service_name, socket_timeout=3.0)

    print("Connected to Redis")
    print("Set: {}".format(r.set("foo", "bar")))
    print("Get: {}".format(r.get("foo")))

    # just for completeness close the connection pool
    r.connection_pool.disconnect()


if __name__ == "__main__":
    main()
