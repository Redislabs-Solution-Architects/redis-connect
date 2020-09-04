
package com.rl.sample.jedis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.Protocol;

/**
 * Jedis Pool example with password
 */
public class Simple {
   String host;
   int port;
   String password;

    public static void main(String[] args) {
        if (!(args.length ==  2 || args.length == 3)) {
            System.out.println("Usage: host port password");
            System.exit(1);
        }
        Simple example = new Simple();
        example.host = args[0];
        example.port = Integer.parseInt(args[1]);
        if (args.length == 3) example.password = args[2];

        JedisPool pool = example.getPool();
        try (Jedis jedis = pool.getResource()) {
            String resp = jedis.set("foo", "bar");
            System.out.println("Set:" + resp);
            System.out.println("Get: " + jedis.get("foo"));
        }
        //close the pool when application terminates
        pool.close();
    }

    private JedisPool getPool() {
        JedisPoolConfig poolConfig = new JedisPoolConfig();
        poolConfig.setTestWhileIdle(false);
        poolConfig.setTestOnBorrow(false);
        poolConfig.setTestOnReturn(false);
        poolConfig.setMinEvictableIdleTimeMillis(60000);
        poolConfig.setTimeBetweenEvictionRunsMillis(30000);
        poolConfig.setNumTestsPerEvictionRun(-1);
        poolConfig.setMaxTotal(500);

        return new JedisPool(poolConfig, host, port, Protocol.DEFAULT_TIMEOUT, password, Protocol.DEFAULT_DATABASE);
    }
}
