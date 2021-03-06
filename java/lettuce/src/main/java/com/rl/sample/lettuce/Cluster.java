package com.rl.sample.lettuce;


import io.lettuce.core.RedisURI;
import io.lettuce.core.cluster.RedisClusterClient;
import io.lettuce.core.cluster.api.StatefulRedisClusterConnection;
import io.lettuce.core.cluster.api.sync.RedisAdvancedClusterCommands;

import java.util.Arrays;

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

        //RedisClient and Connection should be long lived and are thread safe
        RedisClusterClient client = example.getClient();
        StatefulRedisClusterConnection<String, String> connection = client.connect();

        RedisAdvancedClusterCommands<String, String> commands = connection.sync();

        String resp = commands.set("foo", "bar");
        System.out.println("Set:" + resp);
        System.out.println("Get: " + commands.get("foo"));

        //close the connection and client when application terminates
        connection.close();
        client.shutdown();
    }

    private RedisClusterClient getClient() {
        //you can create more nodes and add to list when creating client
        RedisURI node1 = RedisURI.create(host, port);
        if (password != null) {
            node1.setPassword(password);
        }
        return RedisClusterClient.create(Arrays.asList(node1 /* , node2*/));
    }
}
