# .NET StackExchange.Redis 
* Library: [StackExchange.Redis](https://stackexchange.github.io/StackExchange.Redis/)
* Library version : 2.1.58. RS sentinel does not work with version 2.1.58 and uses older version 2.1.30
* Runtime Version: .Net Core 3.1.201
* RS version: 6.0.6-35
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | Y      | Y       | Y      |

* N/A : Not Available
* N/C : Not researched or checked

## Comments/Gotchas
Major OSS .Net library
* Simple and Cluster client are same
* Does not support blocking operation and wait commands

## Prerequisite

Install [.Net Core](https://dotnet.microsoft.com/download)

## Setup

## Run
Password is optional for all samples

### Simple/Cluster
cd simple
```bash
dotnet build
dotnet run host port password
```
### Sentinel
cd sentinel
```bash
dotnet build
dotnet run sentinelhost sentinelport service password
```

### Simple/Cluster TLS
Change the location of PFX file and password in code. For oneway TLS comment out the certificate line

cd simpletls
```bash
dotnet build
dotnet run host port password
```

### Sentinel TLS
Change the location of PFX file and password in code. For oneway TLS comment out the certificate line. Note for Discovery service the sample also uses TLS

cd sentineltls
```bash
dotnet build
dotnet run sentinelhost sentinelport service password
```
