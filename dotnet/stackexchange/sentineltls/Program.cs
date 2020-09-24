using System;
using StackExchange.Redis;
using System.Security.Cryptography.X509Certificates;

namespace sentineltls
{
    class Program
    {
        const string PFX_FILE = "../../../testscripts/tls/db_cert.pfx";
        const string PFX_PASSWORD = "A4TVrVCHg8Ztm";
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

            //you can add more sentinels here
            configuration.EndPoints.Add(sentinelHost, sentinelPort);
            configuration.TieBreaker = "";
            configuration.Ssl = true; //connect to sentinel service using TLS

            /* If certificate is self signed and not trusted by OS.
               We are just returning true and  doing no validation
               For Production you should use proper certificates and comment the callback
             */
            configuration.CertificateValidation += (sender, cert, chain, errors) =>
                {
                    /*Console.WriteLine("errors: " + errors);
                    foreach (var c in chain.ChainElements)
                    {
                        Console.WriteLine(c.Certificate.GetNameInfo(X509NameType.SimpleName, false));
                    }*/
                    return true;
                };

            configuration.CommandMap = CommandMap.Sentinel;
            ConnectionMultiplexer sentinel = ConnectionMultiplexer.Connect(configuration, Console.Out);

            var masterConfig = new ConfigurationOptions()
            {
                ServiceName = serviceName,
                Password = password,
                Ssl = true,
            };

            /* If certificate is selfsigned and not trusted. 
               We are just returning true and  doing no validation
               For Production you should use proper certificates and comment the callback
             */
            masterConfig.CertificateValidation += (sender, cert, chain, errors) =>
                {
                    /*Console.WriteLine("errors: " + errors);
                    foreach (var c in chain.ChainElements)
                    {
                        Console.WriteLine(c.Certificate.GetNameInfo(X509NameType.SimpleName, false));
                    }*/
                    return true;
                };
            //For mTLS aka 2 way TLS provide the client certificate for authentication. Note PFX file must have password.
            //Comment the line if you are using 1 way TLS
            masterConfig.CertificateSelection += delegate { return new X509Certificate2(PFX_FILE, PFX_PASSWORD); };

            return sentinel.GetSentinelMasterConnection(masterConfig, Console.Out);
        }
    }
}