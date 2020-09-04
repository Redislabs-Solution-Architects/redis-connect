Install golang
go get github.com/gomodule/redigo/redis
go build
run the compiled program

requires separate modules for sentinel and cluster support
cluster support modules are not mantained had to add pull request github.com/pihao/redis-go-cluster v1.1.1  