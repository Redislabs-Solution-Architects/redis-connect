package main

import (
	"errors"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/FZambia/sentinel"
	"github.com/gomodule/redigo/redis"
)

func main() {
	var sentinelHost, sentinelPort, service, password string

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

	// you can add more sentinels here
	sentinels := []string{sentinelHost + ":" + sentinelPort}
	pool := newPool(sentinels, service, password)

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
	pool.Close()
}

func newPool(addsr []string, service string, password string) *redis.Pool {
	sntnl := &sentinel.Sentinel{
		Addrs:      addsr,
		MasterName: service,
		Dial: func(addr string) (redis.Conn, error) {
			timeout := 500 * time.Millisecond
			c, err := redis.DialTimeout("tcp", addr, timeout, timeout, timeout)
			if err != nil {
				return nil, err
			}
			return c, nil
		},
	}

	return &redis.Pool{
		MaxIdle:     3,
		IdleTimeout: 240 * time.Second,
		Dial: func() (redis.Conn, error) {
			masterAddr, err := sntnl.MasterAddr()
			if err != nil {
				return nil, err
			}
			c, err := redis.Dial("tcp", masterAddr)
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
		},
		TestOnBorrow: func(c redis.Conn, t time.Time) error {
			if !sentinel.TestRole(c, "master") {
				return errors.New("Role check failed")
			}
			return nil
		},
	}
}
