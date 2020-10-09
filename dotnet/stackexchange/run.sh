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
source "${DIR}"/../../testscripts/env.sh

cd "${DIR}"/simple
dotnet build
printf "\nSimple....\n"
dotnet run $SIMPLE
dotnet run $SIMPLE_P
printf "\nCluster....\n"
dotnet run $CLUSTER
dotnet run $CLUSTER_P

cd "${DIR}"/sentinel
dotnet build
printf "\nSentinel....\n"
dotnet run $SENTINEL
dotnet run $SENTINEL_P

cd "${DIR}"/simpletls
dotnet build
printf "\nSimple TLS....\n"
dotnet run $SIMPLE_TLS
dotnet run $SIMPLE_P_TLS
printf "\nCluster TLS....\n"
dotnet run $CLUSTER_TLS
dotnet run $CLUSTER_P_TLS

cd "${DIR}"/sentineltls
dotnet build
printf "\nSentinel TLS....\n"
dotnet run $SENTINEL_TLS
dotnet run $SENTINEL_P_TLS

cd "${DIR}"