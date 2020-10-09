package com.rl.sample.lettuce;


import io.lettuce.core.ClientOptions;
import io.lettuce.core.RedisClient;
import io.lettuce.core.RedisURI;
import io.lettuce.core.SslOptions;
import io.lettuce.core.api.StatefulRedisConnection;
import io.lettuce.core.api.sync.RedisCommands;

import java.io.File;

public class SentinelTLS {
    static final String TRUST_STORE = "../../testscripts/tls/sample_ca_truststore.jks";
    static final String TRUST_STORE_PASSWORD = "A4TVrVCHg8Ztm";
    static final String KEY_STORE = "../../testscripts/tls/db_cert.pfx";
    static final String KEY_STORE_PASSWORD = "A4TVrVCHg8Ztm";

    private String host;
    private int port;
    private String password;
    private String service;

    public static void main(String[] args) {
        if (!(args.length == 3 || args.length == 4)) {
            System.out.println("Usage: sentinelhost sentinelport service password");
            System.exit(1);
        }

        SentinelTLS example = new SentinelTLS();
        example.host = args[0];
        example.port = Integer.parseInt(args[1]);
        example.service = args[2];
        if (args.length == 4) example.password = args[3];

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
        //you can add more sentinel instances using withSentinel
        RedisURI.Builder uriBuilder = RedisURI.Builder.sentinel(host, port, service)/*.withSentinel(sentinelhost2, sentinalport2)*/;
        if (password != null) {
            uriBuilder = uriBuilder.withPassword(password);
        }

        //Note Verify Peer is false. Add node IP address to SAN in certificate
        uriBuilder.withSsl(true).withVerifyPeer(false);
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
