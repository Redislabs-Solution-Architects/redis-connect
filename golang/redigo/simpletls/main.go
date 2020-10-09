package main

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"

	"github.com/gomodule/redigo/redis"
)

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

func newPool(addr string, password string) *redis.Pool {
	// create the ca certs pool to trust our ca
	caCert, err := ioutil.ReadFile("../../../testscripts/tls/ca_cert.pem")
	if err != nil {
		log.Fatal(err)
	}

	caCertPool := x509.NewCertPool()
	caCertPool.AppendCertsFromPEM(caCert)

	// load the client certificates
	cert, err := tls.LoadX509KeyPair("../../../testscripts/tls/db_cert.pem", "../../../testscripts/tls/db_key.pem")
	if err != nil {
		log.Fatal(err)
	}

	cfg := &tls.Config{
		Certificates: []tls.Certificate{cert},
		RootCAs:      caCertPool,
	}

	return &redis.Pool{
		MaxIdle:     3,
		IdleTimeout: 240 * time.Second,

		Dial: func() (redis.Conn, error) {
			return redis.Dial("tcp", addr,
				redis.DialPassword(password),
				redis.DialUseTLS(true),
				redis.DialTLSConfig(cfg))
		}}
}
