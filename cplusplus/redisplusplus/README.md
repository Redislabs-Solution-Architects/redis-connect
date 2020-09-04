Follow the instructions at https://github.com/sewenew/redis-plus-plus?undefined#installation to install hiredis and redisplusplus

g++ -std=c++11 -o simple  simple.cpp -lredis++ -lhiredis -pthread
g++ -std=c++11 -o cluster  cluster.cpp -lredis++ -lhiredis -pthread
g++ -std=c++11 -o sentinel  sentinel.cpp -lredis++ -lhiredis -pthread

//static compile
g++ -std=c++11 -o sentinel sentinel.cpp /Users/kyousaf/Dev/Development3/repo/connect/cplusplus/redisplusplus/delete/redis-plus-plus/compile/lib/libredis++.a /Users/kyousaf/Dev/Development3/repo/connect/cplusplus/redisplusplus/delete/hiredis/libhiredis.a -pthread