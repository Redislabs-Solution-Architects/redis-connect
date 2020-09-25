#include <sw/redis++/redis++.h>

#include <iostream>

using namespace sw::redis;

int main(int argc, char* argv[]) {
  if (!(argc == 4 || argc == 5)) {
    std::cout << "Usage: sentinelhost sentinelport service password "
              << std::endl;
    return 1;
  }

  auto sentinel_host = argv[1];
  auto sentinel_port = std::stoi(argv[2]);
  auto service = argv[3];

  //sentinel options. 
  SentinelOptions sentinel_opts;
  sentinel_opts.nodes = {{sentinel_host, sentinel_port}};
  sentinel_opts.connect_timeout = std::chrono::milliseconds(1000);
  sentinel_opts.socket_timeout = std::chrono::milliseconds(1000);
  auto sentinel = std::make_shared<Sentinel>(sentinel_opts);

  //connection options note timeouts are required
  ConnectionOptions opts;
  if (argc == 5) {
    opts.password = argv[4];  // password
  }
  opts.connect_timeout = std::chrono::milliseconds(1000);
  opts.socket_timeout = std::chrono::milliseconds(1000);
  opts.tls.enabled = true;
  opts.tls.cert = "../../testscripts/tls/db_cert.pem";
  opts.tls.key = "../../testscripts/tls/db_key.pem";
  opts.tls.cacert = "../../testscripts/tls/ca_cert.pem";
  ConnectionPoolOptions pool_opts;
  pool_opts.size = 3;
  pool_opts.wait_timeout = std::chrono::milliseconds(100);

  auto redis = Redis(sentinel, service, Role::MASTER, opts, pool_opts);

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
