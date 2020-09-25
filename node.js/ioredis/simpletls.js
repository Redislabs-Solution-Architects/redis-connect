'use strict';
if (!(process.argv.length === 4 || process.argv.length === 5)) {
    console.log("Usage: host port password")
    process.exit(1)
}
const Redis = require("ioredis");
const fs = require('fs');

var host = process.argv[2];
var port = process.argv[3];
var password = undefined;
if (process.argv.length === 5) {
    password = process.argv[4];
}
var tlsOpts = {
    key: fs.readFileSync('../../testscripts/tls/db_key.pem'),
    cert: fs.readFileSync('../../testscripts/tls/db_cert.pem'),
    ca: [fs.readFileSync('../../testscripts/tls/ca_cert.pem')],
    enableTrace: true,
    checkServerIdentity: (hostname, cert) => {return null;}, //return null if you do not want to verify hostname
};
var redis = new Redis({
    port: port,
    host: host,
    password: password,
    tls: tlsOpts
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
// we wait for a second for all commands to complete and then close the connection,
setTimeout(function () { redis.quit() }, 1000);