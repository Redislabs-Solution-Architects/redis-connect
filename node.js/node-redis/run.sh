DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../../testscripts/env.sh

npm install
node simple.js $SIMPLE
node simple.js $SIMPLE_P
node simpletls.js $SIMPLE_TLS
node simpletls.js $SIMPLE_P_TLS