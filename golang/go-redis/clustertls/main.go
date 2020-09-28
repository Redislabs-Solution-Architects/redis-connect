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
	//use this to verify certificates, or create certificates with IP SAN
	verifyCerts := func(rawCerts [][]byte, verifiedChains [][]*x509.Certificate) error {
		/*for i := 0; i < len(rawCerts); i++ {
			cert, err := x509.ParseCertificate(rawCerts[i])
			if err != nil {
				fmt.Println("Error: ", err)
				continue
			}
			fmt.Println(cert.DNSNames, cert.Subject)
		}*/
		return nil
	}

	cfg := &tls.Config{
		Certificates:          []tls.Certificate{cert},
		InsecureSkipVerify:    true, //verify certificates using custom code
		RootCAs:               caCertPool,
		VerifyPeerCertificate: verifyCerts}

	return redis.NewClusterClient(&redis.ClusterOptions{
		Addrs:     nodes,
		Password:  password,
		TLSConfig: cfg,
	})
}
