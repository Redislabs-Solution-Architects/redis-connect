package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/pihao/redis-go-cluster"
)

var host, port, password string

func main() {

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
	//cluster is thread safe
	cluster, err := newPool(nodes, password)
	if err != nil {
		log.Fatal(err)
	}

	defer cluster.Close()

	n, err := cluster.Do("SET", "foo", "bar")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("SET:%s\n", n)

	n, err = cluster.Do("GET", "foo")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("GET:%s\n", n)
}

func newPool(nodes []string, password string) (*redis.Cluster, error) {
	return redis.NewCluster(
		&redis.Options{
			StartNodes:   nodes,
			ConnTimeout:  50 * time.Millisecond,
			ReadTimeout:  50 * time.Millisecond,
			WriteTimeout: 50 * time.Millisecond,
			KeepAlive:    16,
			AliveTime:    60 * time.Second,
			Password:     password,
		})

}
