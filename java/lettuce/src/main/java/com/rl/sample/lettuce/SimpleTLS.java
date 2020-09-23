
package com.rl.sample.lettuce;


import io.lettuce.core.ClientOptions;
import io.lettuce.core.RedisClient;
import io.lettuce.core.RedisURI;
import io.lettuce.core.SslOptions;
import io.lettuce.core.api.StatefulRedisConnection;
import io.lettuce.core.api.sync.RedisCommands;

import java.io.File;

/**
 * Lettuce example
 */
public class SimpleTLS {
    final static String TRUST_STORE = "../../testscripts/tls/sample_ca_truststore.jks";
    final static String TRUST_STORE_PASSWORD = "A4TVrVCHg8Ztm";
    final static String KEY_STORE = "../../testscripts/tls/db_cert.pfx";
    final static String KEY_STORE_PASSWORD = "A4TVrVCHg8Ztm";

    String host;
    int port;
    String password;

    public static void main(String[] args) {
        //Disable JVM DNS caching.
        java.security.Security.setProperty("networkaddress.cache.ttl" , "0");
        java.security.Security.setProperty("networkaddress.cache.negative.ttl", "0");

        if (!(args.length == 2 || args.length == 3)) {
            System.out.println("Usage: host port password");
            System.exit(1);
        }
        SimpleTLS example = new SimpleTLS();
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

        uriBuilder.withSsl(true);
        SslOptions sslOptions = SslOptions.builder().jdkSslProvider()
                .keystore(new File(KEY_STORE), KEY_STORE_PASSWORD.toCharArray())
                .truststore(new File(TRUST_STORE), TRUST_STORE_PASSWORD)
                .build();
        ClientOptions clientOptions = ClientOptions.builder().sslOptions(sslOptions).build();

        RedisClient client = RedisClient.create(uriBuilder.build());
        client.setOptions(clientOptions);
        return client;
    }
}