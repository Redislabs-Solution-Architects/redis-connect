package com.rl.sample.jedis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisSentinelPool;

import java.util.HashSet;

public class Sentinel {
    String host;
    int port;
    String password;
    String service;


    public static void main(String[] args) {
        if (!(args.length == 3 || args.length == 4) ) {
            System.out.println("Usage: sentinelhost sentinelport service password");
            System.exit(1);
        }

        Sentinel example = new Sentinel();
        example.host = args[0];
        example.port = Integer.parseInt(args[1]);
        example.service = args[2];
        if (args.length == 4) example.password = args[3];

        JedisSentinelPool pool = example.getPool();

        try (Jedis jedis = pool.getResource()) {
            String resp = jedis.set("foo", "bar");
            System.out.println("Set: " + resp);
            System.out.println("Get: " + jedis.get("foo"));
        }

        //close the pool when application terminates
        pool.close();
    }


    private JedisSentinelPool getPool() {
        HashSet sentinels = new HashSet<String>();
        //You can add more sentinels here
        sentinels.add(host + ":" + port);
        return new JedisSentinelPool(service, sentinels, password);
    }



}
