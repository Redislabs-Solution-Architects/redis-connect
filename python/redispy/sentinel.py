import redis
import redis.sentinel
import sys

def main():
    if not(len(sys.argv) == 4 or len(sys.argv) == 5):
        print("Usage: sentinelhost sentinelport service password")
        exit(1)
    sentinel_host = sys.argv[1]
    sentinel_port = sys.argv[2]
    service_name = sys.argv[3]

    password = None
    if len(sys.argv) == 5:
        password = sys.argv[4]

    #you can add more sentinels to the list 
    sentinel_list = [(sentinel_host,sentinel_port)]
    s = redis.sentinel.Sentinel(sentinel_list, socket_timeout=0.1)
    r = s.master_for(service_name, socket_timeout=0.1, password=password)
    
    print("Connected to Redis")
    print("Set: {}".format (r.set("foo","bar")))
    print("Get: {}".format(r.get("foo")))
    
    #just for completeness close the connection pool
    r.connection_pool.disconnect()
    

if __name__== "__main__":
  main()