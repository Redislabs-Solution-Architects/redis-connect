'use strict';
if (!(process.argv.length === 5 || process.argv.length === 6)) {
    console.log("Usage: sentinelhost sentinelport service password")
    process.exit(1)
}

const Redis = require("ioredis");

var sentinelHost = process.argv[2];
var sentinelPort = process.argv[3];
var service = process.argv[4];
var password = undefined;
if (process.argv.length === 6) {
    password = process.argv[5];
}

var redis = new Redis({
    sentinels: [{
        host: sentinelHost,
        port: sentinelPort
    }], //you can add more sentinels here
    name: service,
    password: password
});

redis.on("error", function (error) {
    console.error("Error in connection");
    console.error(error);
});

redis.set("foo", "bar", function (err, result) {
    if (err) {
        return console.error(err);
    }
    console.log("SET:", result);
});


redis.get("foo").then(function (result) {
    console.log("GET:", result);
});
//close connection
redis.quit()