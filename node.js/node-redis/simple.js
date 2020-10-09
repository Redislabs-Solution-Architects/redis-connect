
'use strict'
if (!(process.argv.length === 4 || process.argv.length === 5)) {
  console.log('Usage: host port password')
  process.exit(1)
}
const redis = require('redis')
var host = process.argv[2]
var port = process.argv[3]
var password = undefined
if (process.argv.length === 5) {
  password = process.argv[4]
}

const client = redis.createClient({ host: host, port: port, password: password })
client.on('error', function (error) {
  console.error('Error in connection')
  console.error(error)
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

// close the connection after all commands are processed
client.quit()
