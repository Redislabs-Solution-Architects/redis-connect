#include <sw/redis++/redis++.h>

#include <iostream>

using namespace sw::redis;

int main(int argc, char* argv[]) {
  if (!(argc == 3 || argc == 4)) {
    std::cout << "Usage: host port password " << std::endl;
    return 1;
  }

  ConnectionOptions opts;
  opts.host = argv[1];
  opts.port = std::stoi(argv[2]);
  if (argc == 4) {
    opts.password = argv[3];
  }
  opts.socket_timeout = std::chrono::milliseconds(50);

  ConnectionPoolOptions pool_opts;
  pool_opts.size = 3;
  pool_opts.wait_timeout = std::chrono::milliseconds(50);

  auto redis = Redis(opts, pool_opts);

  auto v1 = redis.set("foo", "bar");
  if (v1) {
    std::cout << "Set: " << v1 << std::endl;
  } else {
      std::cout << "Could not set value" << std::endl;
  }

  auto v2 = redis.get("foo");
  if (v2) {
    std::cout << "Get: " << *v2 << std::endl;
  } else {
      std::cout << "Could not get value" << std::endl;
  }
  return 0;
}