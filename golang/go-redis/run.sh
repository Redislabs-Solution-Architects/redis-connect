#!/bin/bash

echo "                                                                   o     o              ";
echo "                                                                  <|>  _<|>_            ";
echo "                                                                  < \                   ";
echo "   o__ __o/    o__ __o             \o__ __o     o__  __o     o__ __o/    o        __o__ ";
echo "  /v     |    /v     v\   _\__o__   |     |>   /v      |>   /v     |    <|>      />  \  ";
echo " />     / \  />       <\       \   / \   < >  />      //   />     / \   / \      \o     ";
echo " \      \o/  \         /           \o/        \o    o/     \      \o/   \o/       v\    ";
echo "  o      |    o       o             |          v\  /v __o   o      |     |         <\   ";
echo "  <\__  < >   <\__ __/>            / \          <\/> __/>   <\__  / \   / \   _\o__</   ";
echo "         |                                                                              ";
echo " o__     o                                                                              ";
echo " <\__ __/>                                                                              ";


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

#goloang go-redis
cd ${DIR}/simple
go build
./simple $SIMPLE
./simple $SIMPLE_P

cd ${DIR}/sentinel
go build
./sentinel $SENTINEL
./sentinel $SENTINEL_P

cd ${DIR}/cluster
go build
./cluster $CLUSTER
./cluster $CLUSTER_P
cd ${DIR}