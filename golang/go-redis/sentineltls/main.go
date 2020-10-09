package main

/* NOT WORKING AS OF v8.2.2 */
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

	r := newClient(sentinels, service, password)
	ctx := context.Background()

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

	r.Close()

}

func newClient(addrs []string, service string, password string) *redis.Client {

	// create the ca certs pool to trust our ca
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

	customVerify := func(rawCerts [][]byte, verifiedChains [][]*x509.Certificate) error {
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
		InsecureSkipVerify:    true,
		RootCAs:               caCertPool,
		VerifyPeerCertificate: customVerify,
	}

	return redis.NewFailoverClient(&redis.FailoverOptions{
		MasterName:    service,
		SentinelAddrs: addrs,
		Password:      password,
		TLSConfig:     cfg,
	})
}
