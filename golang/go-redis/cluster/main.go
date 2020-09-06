package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/go-redis/redis/v8"
)

func main() {
	var host, port, password string

	if !(len(os.Args) == 3 || len(os.Args) == 4) {
		fmt.Println("Usage: host port  password")
		os.Exit(1)
	}
	host = os.Args[1]
	port = os.Args[2]
	if len(os.Args) == 4 {
		password = os.Args[3]
	}

	//you can add more nodes here
	nodes := []string{host + ":" + port}
	//clusterClient is safe for concurrent access
	r := newClient(nodes, password)
	defer r.Close()

	var ctx = context.Background()

	v, err := r.Set(ctx, "foo", "bar", 0).Result()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Set:%s\n", v)

	v, err = r.Get(ctx, "foo").Result()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Get:%s\n", v)
}

func newClient(nodes []string, password string) *redis.ClusterClient {
	return redis.NewClusterClient(&redis.ClusterOptions{
		Addrs:    nodes,
		Password: password,
	})
}
