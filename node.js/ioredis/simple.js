'use strict';
if (!(process.argv.length === 4 || process.argv.length === 5)) {
    console.log("Usage: host port password")
    process.exit(1)
}
const Redis = require("ioredis");

var host = process.argv[2];
var port = process.argv[3];
var password = undefined;
if (process.argv.length === 5) {
    password = process.argv[4];
}

var redis = new Redis({
    port: port,
    host: host,
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