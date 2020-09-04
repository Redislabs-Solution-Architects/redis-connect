
package com.rl.sample.lettuce;


import io.lettuce.core.RedisClient;
import io.lettuce.core.RedisURI;
import io.lettuce.core.api.StatefulRedisConnection;
import io.lettuce.core.api.sync.RedisCommands;

/**
 * Lettuce example
 */
public class Simple {
    String host;
    int port;
    String password;

    public static void main(String[] args) {
        if (!(args.length == 2 || args.length == 3)) {
            System.out.println("Usage: host port password");
            System.exit(1);
        }
        Simple example = new Simple();
        example.host = args[0];
        example.port = Integer.parseInt(args[1]);
        if (args.length == 3) example.password = args[2];

        //RedisClient and Connection should be long lived and are thread safe
        RedisClient client = example.getClient();
        StatefulRedisConnection<String, String> connection = client.connect();

        RedisCommands<String, String> commands = connection.sync();
        String resp = commands.set("foo", "bar");
        System.out.println("Set:" + resp);
        System.out.println("Get: " + commands.get("foo"));

        //close the connection and client when application terminates
        connection.close();
        client.shutdown();
    }

    private RedisClient getClient() {
        RedisURI.Builder uriBuilder = RedisURI.Builder.redis(host).withPort(port);
        if (password != null) {
            uriBuilder = uriBuilder.withPassword(password);
        }

        return RedisClient.create(uriBuilder.build());
    }
}