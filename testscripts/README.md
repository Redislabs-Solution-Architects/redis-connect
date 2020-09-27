Helper test scripts and snippets, for quick testing. These scripts are for testing during development only and are quite fragile. First cut. Need to find a better way for testing

The test script assumes that you have setup the environment for each programming language

**Important** `cd testscripts` as all scripts use relative path from this directory

# Setup the environment
Copy `env_template.sh` to `env.sh` and setup the environment variables for your RS cluster. **All scripts use these environment varialbls**
```
source ./env.sh
```

# Generate TLS Certificates
Run the script to create TLS certificates
```
./tlsgen.sh
```
# Setup RS

## setup
```
 python3 -m venv venv
 source venv/bin/activate
```

Install the dependencies
```
 pip install -r requirements.txt 
 ```
## Setup Proxy Certificate (Caution)
**This script will set the TLS certificates for the proxy**
```
python rs_setproxycert.py
```
## Create Databases 
 ```
 python rs_createdb.py
 ``` 
## Deactivate Python venv
```
deactivate
```
 # Run the tests
 ```
 ./tests.sh
 ```



