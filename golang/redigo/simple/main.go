package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/gomodule/redigo/redis"
)

var host, port, password string

func main() {
	var host, port, password string
	if !(len(os.Args) == 3 || len(os.Args) == 4) {
		fmt.Println("Usage: host port password")
		os.Exit(1)
	}
	host = os.Args[1]
	port = os.Args[2]
	if len(os.Args) == 4 {
		password = os.Args[3]
	}

	pool := newPool(host+":"+port, password)

	defer pool.Close()

	conn := pool.Get()
	n, err := conn.Do("SET", "foo", "bar")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("SET:%s\n", n)

	n, err = conn.Do("GET", "foo")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("GET:%s\n", n)
	conn.Close()
}

func newPool(addr string, password string) *redis.Pool {
	return &redis.Pool{
		MaxIdle:     3,
		IdleTimeout: 240 * time.Second,

		Dial: func() (redis.Conn, error) {
			c, err := redis.Dial("tcp", addr)
			if err != nil {
				return nil, err
			}
			if password != "" {
				if _, err := c.Do("AUTH", password); err != nil {
					c.Close()
					return nil, err
				}
			}

			return c, nil
		}}
}
