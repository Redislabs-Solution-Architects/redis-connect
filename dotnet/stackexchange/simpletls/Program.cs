using System;
using StackExchange.Redis;
using System.Security.Cryptography.X509Certificates;


namespace simpletls
{
    class Program
    {
        const string PFX_FILE = "../../../testscripts/tls/db_cert.pfx";
        const string PFX_PASSWORD = "A4TVrVCHg8Ztm";
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
                Password = password,
                Ssl = true,
            };

            /* If certificate is self signed and not trusted by OS.
              We are just returning true and  doing no validation
              For Production you should use proper certificates and comment the callback
            */
            config.CertificateValidation += (sender, cert, chain, errors) =>
              {
                  /*Console.WriteLine("errors: " + errors);
                  foreach (var c in chain.ChainElements)
                  {
                      Console.WriteLine(c.Certificate.GetNameInfo(X509NameType.SimpleName, false));
                  }*/

                  return true;
              };

            //comment this line for oneway TLS
            config.CertificateSelection += delegate { return new X509Certificate2(PFX_FILE, PFX_PASSWORD); };

            ConnectionMultiplexer redis = ConnectionMultiplexer.Connect(config);

            IDatabase db = redis.GetDatabase();
            Console.WriteLine("Set foo: " + db.StringSet("foo", "bar"));
            Console.WriteLine("Get foo: " + db.StringGet("foo"));
            redis.Close();
        }

    }
}
