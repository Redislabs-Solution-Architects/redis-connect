using System;
using StackExchange.Redis;

namespace simple
{
    class Program
    {
        static string host;
        static int port;

        static string password;
        static void Main(string[] args)
        {
            if (!(args.Length == 2 || args.Length == 3))
            {
                Console.WriteLine("Usage host port password");
                System.Environment.Exit(1);
            }
            host = args[0];
            port = int.Parse(args[1]);
            if (args.Length == 3) password = args[2];


            ConfigurationOptions config = new ConfigurationOptions
            {
                EndPoints = { { host, port } }, //for cluster you can endpoints for nodes here
                Password = password
            };

            ConnectionMultiplexer redis = ConnectionMultiplexer.Connect(config);

            IDatabase db = redis.GetDatabase();
            Console.WriteLine("Set foo: " + db.StringSet("foo", "bar"));
            Console.WriteLine("Get foo: " + db.StringGet("foo"));
            redis.Close();
        }

    }
}
