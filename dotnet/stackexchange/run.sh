#!/bin/bash

echo "  ██████ ▄▄▄█████▓ ▄▄▄       ▄████▄   ██ ▄█▀▓█████ ▒██   ██▒ ▄████▄   ██░ ██  ▄▄▄       ███▄    █   ▄████ ▓█████ ";
echo "▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▒██▀ ▀█   ██▄█▒ ▓█   ▀ ▒▒ █ █ ▒░▒██▀ ▀█  ▓██░ ██▒▒████▄     ██ ▀█   █  ██▒ ▀█▒▓█   ▀ ";
echo "░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▒▓█    ▄ ▓███▄░ ▒███   ░░  █   ░▒▓█    ▄ ▒██▀▀██░▒██  ▀█▄  ▓██  ▀█ ██▒▒██░▄▄▄░▒███   ";
echo "  ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄ ▒▓█  ▄  ░ █ █ ▒ ▒▓▓▄ ▄██▒░▓█ ░██ ░██▄▄▄▄██ ▓██▒  ▐▌██▒░▓█  ██▓▒▓█  ▄ ";
echo "▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒▒ ▓███▀ ░▒██▒ █▄░▒████▒▒██▒ ▒██▒▒ ▓███▀ ░░▓█▒░██▓ ▓█   ▓██▒▒██░   ▓██░░▒▓███▀▒░▒████▒";
echo "▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒░░ ▒░ ░▒▒ ░ ░▓ ░░ ░▒ ▒  ░ ▒ ░░▒░▒ ▒▒   ▓▒█░░ ▒░   ▒ ▒  ░▒   ▒ ░░ ▒░ ░";
echo "░ ░▒  ░ ░    ░      ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░ ░ ░  ░░░   ░▒ ░  ░  ▒    ▒ ░▒░ ░  ▒   ▒▒ ░░ ░░   ░ ▒░  ░   ░  ░ ░  ░";
echo "░  ░  ░    ░        ░   ▒   ░        ░ ░░ ░    ░    ░    ░  ░         ░  ░░ ░  ░   ▒      ░   ░ ░ ░ ░   ░    ░   ";
echo "      ░                 ░  ░░ ░      ░  ░      ░  ░ ░    ░  ░ ░       ░  ░  ░      ░  ░         ░       ░    ░  ░";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

cd ${DIR}/simple
dotnet build
dotnet run $SIMPLE
dotnet run $SIMPLE_P
dotnet run $CLUSTER
dotnet run $CLUSTER_P

cd ${DIR}/sentinel
dotnet build
dotnet run $SENTINEL
dotnet run $SENTINEL_P

cd ${DIR}/simpletls
dotnet build
dotnet run $SIMPLE_TLS
dotnet run $SIMPLE_P_TLS
dotnet run $CLUSTER_TLS
dotnet run $CLUSTER_P_TLS

cd ${DIR}/sentineltls
dotnet build
dotnet run $SENTINEL_TLS
dotnet run $SENTINEL_P_TLS

cd ${DIR}


