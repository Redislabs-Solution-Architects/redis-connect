package com.rl.sample.jedis;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.Protocol;

import java.util.HashSet;
import java.util.Set;


public class Cluster {
    private String host;
    private int port;
    private String password;

    public static void main(String[] args) {
        if (!(args.length == 2 || args.length == 3)) {
            System.out.println("Usage: host port password");
            System.exit(1);
        }

        Cluster example = new Cluster();
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
        poolConfig.setMaxTotal(500);
        poolConfig.setMaxIdle(500);

        Set<HostAndPort> jedisClusterNodes = new HashSet<>();
        //add more nodes here
        jedisClusterNodes.add(new HostAndPort(host, port));

        return new JedisCluster(jedisClusterNodes, Protocol.DEFAULT_TIMEOUT, Protocol.DEFAULT_TIMEOUT, 5, password, poolConfig);
    }
}
