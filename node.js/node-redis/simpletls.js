
'use strict';
if (!(process.argv.length === 4 || process.argv.length === 5)) {
  console.log("Usage: host port password")
  process.exit(1)
}

const redis = require("redis");
const tls = require('tls');
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
  //enableTrace: true,
  //checkServerIdentity: (hostname, cert) => {return null;}, //return null if you do not want to do verify hostname
};

const client = redis.createClient({
  "host": host, "port": port,
  "password": password, "tls": tlsOpts
});
client.on("error", function (error) {
  console.error("Error in connection");
  console.error(error);
});

client.set("foo", "bar", function (err, reply) {
  if (err) {
    return console.error(err)
  }
  console.log("SET:", reply);
});


client.get("foo", function (err, reply) {
  if (err) {
    return console.error(err)
  }
  console.log("GET:", reply)
});

// we wait for a second for all commands to complete and then close the connection,
setTimeout(function () { client.quit() }, 1000);