import redis
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

    r = redis.StrictRedis(host=host, port=port, password=password)

    print("Set: {}".format(r.set("foo", "bar")))
    print("Get: {}".format(r.get("foo")))

    r.connection_pool.disconnect()


if __name__ == "__main__":
    main()
