# .NET StackExchange.Redis 
* Library: https://stackexchange.github.io/StackExchange.Redis/
* Library version : 2.1.58
* Runtime Version: .Net Core 3.1.201
* RS version: **ToDo**
* OSS Redis: 6.0.6

|     | Simple | Sentinel| Cluster|
|:--- |:---:   |:---:    |:---:   |
|     | Y      | Y       | Y      |
| TLS | N/C    | N/C     | N/C    | 

* N/A : Not Available
* N/C : Not researched or checked

## Comments
Major OSS .Net library
* Simple and Cluster client are same
* Does not support blocking operation and wait command

## Prerequisite

Install .Net Core https://dotnet.microsoft.com/download 

## Setup

## Run
Password is optional for all samples

### Simple/Cluster
cd simple
```
dotnet build
dotnet run host port password
```
### Sentinel 
cd sentinel
```
dotnet build
dotnet run sentinelhost sentinelport service password
```