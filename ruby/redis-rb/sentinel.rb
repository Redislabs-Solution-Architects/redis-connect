require 'redis'

if !(ARGV.length == 3 || ARGV.length == 4)
    puts "Usage: host port service password"
    return
end

SENTINEL_HOST = ARGV[0]
PORT = ARGV[1]
SERVICE = ARGV[2]
PASSWORD = ARGV.length == 4 ? ARGV[3]:nil
#you can add more sentinels here
SENTINELS = [{host:SENTINEL_HOST, port:PORT}]
begin 
    redis = Redis.new(host: SERVICE, sentinels: SENTINELS, role: :master, password:PASSWORD)
    print "Set: ", redis.set("foo", "bar")
    puts
    print "Get:" ,redis.get("foo")
    puts
    #close connection at end of application
    redis.close
rescue StandardError => e
    puts e.inspect
end


