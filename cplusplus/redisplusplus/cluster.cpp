#include <sw/redis++/redis++.h>

#include <iostream>

using namespace sw::redis;

int main(int argc, char* argv[]) {
  if (!(argc == 3 || argc == 4)) {
    std::cout << "Usage: host port password " << std::endl;
    return 1;
  }

  ConnectionOptions opts;
  opts.host = argv[1]; //Could not find a way to give more than one node in cluster
  opts.port = std::stoi(argv[2]);
  if (argc == 4) {
    opts.password = argv[3];
  }
  opts.socket_timeout = std::chrono::milliseconds(1000);

  ConnectionPoolOptions pool_opts;
  pool_opts.size = 3;
  pool_opts.wait_timeout = std::chrono::milliseconds(100);

  auto redis_cluster = RedisCluster(opts, pool_opts);

  auto v1 = redis_cluster.set("foo", "bar");
  if (v1) {
    std::cout << "Set: " << v1 << std::endl;
  } else {
    std::cout << "Could not set value" << std::endl;
  }

  auto v2 = redis_cluster.get("foo");
  if (v2) {
    std::cout << "Get: " << *v2 << std::endl;
  } else {
    std::cout << "Could not get value" << std::endl;
  }
  return 0;
}