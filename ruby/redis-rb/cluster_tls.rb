# frozen_string_literal: true
require "redis"

if !(ARGV.length == 2 || ARGV.length == 3)
  puts "Usage: host port password"
  return
end

HOST = ARGV[0]
PORT = ARGV[1]
PASSWORD = ARGV.length == 3 ? ARGV[2] : nil
#you can add more nodes here
NODES = [{ host: HOST, port: PORT }]
begin
  redis = Redis.new(cluster: NODES, password: PASSWORD, ssl: true, ssl_params: {
                      ca_file: "../../testscripts/tls/ca_cert.pem",
                      cert: OpenSSL::X509::Certificate.new(File.read("../../testscripts/tls/db_cert.pem")),
                      key: OpenSSL::PKey::RSA.new(File.read("../../testscripts/tls/db_key.pem")),
                      verify_mode: OpenSSL::SSL::VERIFY_PEER,
                      verify_hostname: false,
                      verify_callback: lambda { |preverify_ok, store_context|
                        # do any certificate verification here
                        return preverify_ok
                      },
                    })
  print "Set: ", redis.set("foo", "bar")
  puts
  print "Get:", redis.get("foo")
  puts
  #close connection at end of application
  redis.close
rescue StandardError => e
  puts e.inspect
end
