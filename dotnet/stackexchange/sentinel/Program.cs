using System;
using StackExchange.Redis;

namespace sentinel
{
    class Program
    {
        static string serviceName;
        static string sentinelHost;
        static int sentinelPort;

        static string password;
        static void Main(string[] args)
        {
            if (!(args.Length == 3 || args.Length == 4))
            {
                Console.WriteLine("Usage host port service password");
                System.Environment.Exit(1);
            }
            sentinelHost = args[0];
            sentinelPort = int.Parse(args[1]);
            serviceName = args[2];
            if (args.Length == 4) password = args[3];

            ConnectionMultiplexer redis = getMultiplexer();

            IDatabase db = redis.GetDatabase();
            Console.WriteLine("Set foo: " + db.StringSet("foo", "bar"));
            Console.WriteLine("Get foo: " + db.StringGet("foo"));
            redis.Close();
        }

        static ConnectionMultiplexer getMultiplexer()
        {
            ConfigurationOptions configuration = new ConfigurationOptions();
            configuration.ServiceName = serviceName;

            //you can add more sentinels here
            configuration.EndPoints.Add(sentinelHost, sentinelPort);
            configuration.TieBreaker = "";

            configuration.CommandMap = CommandMap.Sentinel;
            ConnectionMultiplexer sentinel = ConnectionMultiplexer.Connect(configuration, Console.Out);

            var masterConfig = new ConfigurationOptions() { ServiceName = serviceName, Password = password };
            return sentinel.GetSentinelMasterConnection(masterConfig, Console.Out);
        }
    }
}
