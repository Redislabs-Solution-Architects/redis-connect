#!/bin/bash

# ┌───────────┐      ┌───────────┐                   
# │           │      │           │                   
# │   Proxy   │──────▶    ca     │                   
# │           │   ┌──▶           │                   
# └───────────┘   │  └───────────┘                   
#                 │                                  
#  ┌───────────┐  │                                  
#  │           │  │                                  
#  │    db     │──┘           Certificate Chain      
#  │           │                                     
#  └───────────┘                                     


mkdir tls


# This is the one we will use to create certificates
# Signature Algorithm: sha256WithRSAEncryption
# Subject: O = Redis Labs, CN = RL Intermediate Certificate Authority
# Subject Public Key Info:
#     Public Key Algorithm: rsaEncryption
#         RSA Public-Key: (4096 bit)
intermediate_ca(){
    
    printf "** Greating Intermediate Certificate Authority\n"
    
    printf "** Creating Intermediate CA private key\n\n"
    openssl genrsa -out tls/ca_key.pem 4096


    printf "** Creating Intermediate CA public certificate\n\n"
    openssl req \
        -x509 -new -nodes -sha256 \
        -key tls/ca_key.pem \
        -days 3650 \
        -subj '/O=Redis Labs/CN=RL Intermediate Certificate Authority' \
        -out tls/ca_cert.pem
    printf "** Creating Java trust store\n\n"
    rm tls/sample_ca_truststore.jks
    keytool -import -noprompt -file tls/ca_cert.pem -alias ca_cert  -keystore tls/sample_ca_truststore.jks -storepass ${BUNDLE_PASSWORD}
}

# Signature Algorithm: sha256WithRSAEncryption
# Issuer: O = Redis Labs, CN = RL Intermediate Certificate Authority
# Subject: C = GB, ST = London, L = London, O = rl, OU = rl, CN = user1.example.cluster.redislabs.com
# Subject Public Key Info:
#     Public Key Algorithm: rsaEncryption
#         RSA Public-Key: (2048 bit)
# X509v3 Subject Alternative Name: 
#     DNS:example.cluster.redislabs.com, DNS:*.example.cluster.redislabs.com, DNS:internal.example.cluster.redislabs.com, DNS:*.internal.example.cluster.redislabs.com
cluster_certs() {
    printf "** Creating Proxy Private Key\n"
    openssl genrsa -out tls/cluster_key.pem  2048

#Configuration file for alt names
cat <<EOF > tls/cluster_altname.conf
[req] 
distinguished_name=req; 
[san] 
subjectAltName=DNS:${CLUSTER_FQDN},DNS:*.${CLUSTER_FQDN},DNS:internal.${CLUSTER_FQDN},DNS:*.internal.${CLUSTER_FQDN}
EOF
    
    printf "** Creating Proxy CSR\n"
    #Generate CSR.SAN is not used when creating the X509 certificate. It is added here for completeness as an example in case getting commercial certficates
    openssl req  -new  -sha256 \
        -key tls/cluster_key.pem \
        -out tls/cluster.csr \
        -subj "/C=GB/ST=London/L=London/O=rl/OU=rl/CN=user1.${CLUSTER_FQDN}" \
        -reqexts SAN -extensions SAN \
        -config <(cat /etc/ssl/openssl.cnf \
            <(printf "\n[SAN]\nsubjectAltName=DNS:${CLUSTER_FQDN},DNS:*.${CLUSTER_FQDN},DNS:internal.${CLUSTER_FQDN},DNS:*.internal.${CLUSTER_FQDN}"))

    printf "** Creating Proxy Public certificate\n"
    openssl x509 -req -sha256  -days 365 \
        -in tls/cluster.csr \
        -CA tls/ca_cert.pem -CAkey tls/ca_key.pem -CAserial tls/cluster_ca.txt -CAcreateserial \
        -extensions san -extfile tls/cluster_altname.conf \
        -out tls/cluster_cert.pem

    # Delete CSR and ${CLUSTER_FQDN}_altname.conf
    rm tls/cluster.csr tls/cluster_altname.conf

}   


# Generating certificates using port and SAN for DB NOT USED
# Signature Algorithm: sha256WithRSAEncryption
# Issuer: O = Redis Labs, CN = RL Intermediate Certificate Authority
# Subject: C = GB, ST = London, L = London, O = rl, OU = rl, CN = redis-10005.example.cluster.redislabs.com
# X509v3 Subject Alternative Name: 
#     DNS:redis-10005.example.cluster.redislabs.com, DNS:redis-10005.internal.example.cluster.redislabs.com
function generate_db_certs2()
{
    local port=$1
    printf "\n** Creating certificates for endpoint ${port}\n"
    #private key
    openssl genrsa -out tls/${port}_key.pem  2048
    
cat <<EOF > tls/${port}_altname.conf
[req] 
distinguished_name=req; 
[san] 
subjectAltName=DNS:redis-${port}.${CLUSTER_FQDN},DNS:redis-${port}.internal.${CLUSTER_FQDN}
EOF

    openssl req  -new  -sha256 \
        -key tls/${port}_key.pem \
        -out tls/${port}.csr \
        -subj "/C=GB/ST=London/L=London/O=rl/OU=rl/CN=redis-${port}.${CLUSTER_FQDN}" \
        -reqexts SAN -extensions SAN \
        -config <(cat /etc/ssl/openssl.cnf \
            <(printf "\n[SAN]\nsubjectAltName=DNS:redis-${port}.${CLUSTER_FQDN},DNS:redis-${port}.internal.${CLUSTER_FQDN}"))
    
    openssl x509 -req -sha256  -days 365 \
        -in tls/${port}.csr \
        -CA tls/ca_cert.pem -CAkey tls/ca_key.pem -CAserial tls/${port}_ca.txt -CAcreateserial \
        -extensions san -extfile tls/${port}_altname.conf \
        -out tls/${port}_cert.pem

    rm tls/${port}_altname.conf tls/${port}.csr

    #create PFX bundle for .Net
    printf "** Creating DB PFX/pkscs12 bundle for java and .Net\n\n"
    openssl pkcs12 -export -in tls/${port}_cert.pem  -inkey tls/${port}_key.pem -certfile tls/ca_cert.pem -passout pass:${BUNDLE_PASSWORD} -out tls/${port}_cert.pfx
}


# Generating certificates using prefix for db
# Signature Algorithm: sha256WithRSAEncryption
# Issuer: O=Redis Labs, CN=RL Intermediate Certificate Authority
# Subject: C=GB, ST=London, L=London, O=rl, OU=rl, CN=redis-db.k1.demo.redislabs.com
function generate_db_certs()
{
    local prefix=$1
    printf "\n** Creating certificates for endpoint ${port}\n"
    #private key
    openssl genrsa -out tls/${prefix}_key.pem  2048
    
    openssl req  -new  -sha256 \
        -key tls/${prefix}_key.pem \
        -out tls/${prefix}.csr \
        -subj "/C=GB/ST=London/L=London/O=rl/OU=rl/CN=redis-${prefix}.${CLUSTER_FQDN}"
    
    openssl x509 -req -sha256  -days 365 \
        -in tls/${prefix}.csr \
        -CA tls/ca_cert.pem -CAkey tls/ca_key.pem -CAserial tls/${prefix}_ca.txt -CAcreateserial \
        -out tls/${prefix}_cert.pem

    rm tls/${prefix}.csr

    #create PFX bundle/PK12 for .Net and Java
    printf "** Creating Intermediate CA public certificate\n\n"
    openssl pkcs12 -export -in tls/${prefix}_cert.pem  -inkey tls/${prefix}_key.pem -certfile tls/ca_cert.pem -passout pass:${BUNDLE_PASSWORD} -out tls/${prefix}_cert.pfx
}

intermediate_ca
cluster_certs

#generate db certificates
generate_db_certs db