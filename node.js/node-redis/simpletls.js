
'use strict'
if (!(process.argv.length === 4 || process.argv.length === 5)) {
  console.log('Usage: host port password')
  process.exit(1)
}

const redis = require('redis')
const fs = require('fs')

var host = process.argv[2]
var port = process.argv[3]
var password = undefined
if (process.argv.length === 5) {
  password = process.argv[4]
}

var tlsOpts = {
  key: fs.readFileSync('../../testscripts/tls/db_key.pem'),
  cert: fs.readFileSync('../../testscripts/tls/db_cert.pem'),
  ca: [fs.readFileSync('../../testscripts/tls/ca_cert.pem')],
  // enableTrace: true,  //required for TLS connection troubleshooting
  // 
  // For connection to an endpoint configured with non-mutual TLS and 
  // requiring SNI (such as an Openshift Route (HAProxy), set
  // `servername` as below. Additionally, for a self-signed server 
  // certificate Node.js must be configured with `checkServerIdentity` 
  // as below and the environment variable: 
  // NODE_TLS_REJECT_UNAUTHORIZED=0. 
  //   * in code: process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
  //   * in command line: export the above setting per your shell
  //
  // checkServerIdentity: (hostname, cert) => {return null;}, //return null if you do not want to do verify hostname in server certificate
  // servername: host,  
}

const client = redis.createClient({
  host: host, port: port,
  password: password, tls: tlsOpts
})
client.on('error', function (error) {
  console.error('Error in connection')
  console.error(error);
})

client.set('foo', 'bar', function (err, reply) {
  if (err) {
    return console.error(err)
  }
  console.log('SET:', reply)
})

client.get('foo', function (err, reply) {
  if (err) {
    return console.error(err)
  }
  console.log('GET:', reply)
})

// we wait for a second for all commands to complete and then close the connection,
setTimeout(function () {
  client.quit()
}, 1000)
