package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/go-redis/redis/v8"
)

var sentinelHost, sentinelPort, service, password string

func main() {

	if !(len(os.Args) == 4 || len(os.Args) == 5) {
		fmt.Println("Usage: sentinelhost sentinelport service password")
		os.Exit(1)
	}
	sentinelHost = os.Args[1]
	sentinelPort = os.Args[2]
	service = os.Args[3]
	if len(os.Args) == 5 {
		password = os.Args[4]
	}

	//you can add more sentinels here
	sentinels := []string{sentinelHost + ":" + sentinelPort}

	r := newClient(sentinels, service, password)

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

func newClient(addrs []string, service string, password string) *redis.Client {
	return redis.NewFailoverClient(&redis.FailoverOptions{
		MasterName:    service,
		SentinelAddrs: addrs,
		Password:      password,
	})

}
