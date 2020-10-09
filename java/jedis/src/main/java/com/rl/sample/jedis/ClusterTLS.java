package com.rl.sample.jedis;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.Protocol;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;
import java.util.HashSet;
import java.util.Set;


public class ClusterTLS {
    private String host;
    private int port;
    private String password;

    public static void main(String[] args) {
        if (!(args.length == 2 || args.length == 3)) {
            System.out.println("Usage: host port password");
            System.exit(1);
        }

        ClusterTLS example = new ClusterTLS();
        example.host = args[0];
        example.port = Integer.parseInt(args[1]);
        if (args.length == 3) example.password = args[2];

        JedisCluster cluster = example.getJedisCluster();
        String resp = cluster.set("foo", "bar");
        System.out.println("Set:" + resp);
        System.out.println("Get:" + cluster.get("foo"));

        //close at end of application
        cluster.close();
    }


    private JedisCluster getJedisCluster() {
        JedisPoolConfig poolConfig = new JedisPoolConfig();
        poolConfig.setTestWhileIdle(false);
        poolConfig.setTestOnBorrow(false);
        poolConfig.setTestOnReturn(false);
        poolConfig.setMinEvictableIdleTimeMillis(60000);
        poolConfig.setTimeBetweenEvictionRunsMillis(30000);
        poolConfig.setNumTestsPerEvictionRun(-1);
        poolConfig.setMaxTotal(10);
        poolConfig.setMaxIdle(10);

        Set<HostAndPort> jedisClusterNodes = new HashSet<>();
        //add more nodes here
        jedisClusterNodes.add(new HostAndPort(host, port));

        //if the proxy certificate has IP address of nodes in SAN then comment this line out and add params when
        //creating JedisCluster. Note if you add new nodes with new IP address then certificates should be updated
        /*SSLParameters params = new SSLParameters();
        params.setEndpointIdentificationAlgorithm("HTTPS");*/

        //Just print the hostname and peer host, you can verify the ip address to stop MITM attacks.
        //Or use the above via SAN certificates
        HostnameVerifier allHostsValid = new HostnameVerifier() {
            public boolean verify(String hostname, SSLSession session) {
                /*System.out.println("Hostname " + hostname );
                System.out.println("PeerHost " + session.getPeerHost());*/
                return true;
            }
        };

        return new JedisCluster(jedisClusterNodes, Protocol.DEFAULT_TIMEOUT, Protocol.DEFAULT_TIMEOUT,
                5, null, password, null, poolConfig, true, null, null, allHostsValid, null);
    }
}
