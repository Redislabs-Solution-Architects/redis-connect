package main

import (
	"context"
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/go-redis/redis/v8"
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

	//client is safe for use by multiple goroutines
	r := newClient(host+":"+port, password)

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

func newClient(addr string, password string) *redis.Client {
	//create the ca certs pool to trust our ca
	caCert, err := ioutil.ReadFile("../../../testscripts/tls/ca_cert.pem")
	if err != nil {
		log.Fatal(err)
	}

	caCertPool := x509.NewCertPool()
	caCertPool.AppendCertsFromPEM(caCert)

	//load the client certificates
	cert, err := tls.LoadX509KeyPair("../../../testscripts/tls/db_cert.pem", "../../../testscripts/tls/db_key.pem")
	if err != nil {
		log.Fatal(err)
	}

	cfg := &tls.Config{
		Certificates: []tls.Certificate{cert},
		RootCAs:      caCertPool,
	}

	return redis.NewClient(&redis.Options{
		Addr:      addr,
		Password:  password,
		TLSConfig: cfg,
	})
}
