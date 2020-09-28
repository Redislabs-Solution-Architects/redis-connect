#!/bin/bash

echo " _  _   ____   ___   ___          ____   ___   ___    ___    ___  ";
echo ") \/ ( / __ \ \   \ ) __(  ____  /  _ \ ) __( \   \  )_ _(  (  _( ";
echo "|  \ | ))__(( | ) ( | _)  )____( )  ' / | _)  | ) (  _| |_  _) \  ";
echo ")_()_( \____/ /___/ )___(        |_()_\ )___( /___/ )_____()____) ";
echo "                                                                  ";
echo
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

npm install
node simple.js $SIMPLE
node simple.js $SIMPLE_P
node simpletls.js $SIMPLE_TLS
node simpletls.js $SIMPLE_P_TLS