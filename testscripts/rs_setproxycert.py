import urllib3
import os
import requests
import json
from requests.auth import HTTPBasicAuth

urllib3.disable_warnings()  # is this bad?


def main():
    CLUSTER_FQDN = os.environ.get("CLUSTER_FQDN")
    if not CLUSTER_FQDN:
        print("CLUSTER_FQDN variable not set")
        exit(1)

    CLUSTER_USER = os.environ.get("CLUSTER_USER")
    if not CLUSTER_USER:
        print("CLUSTER_USER variable not set")
        exit(1)

    CLUSTER_PASSWORD = os.environ.get("CLUSTER_PASSWORD")
    if not CLUSTER_USER:
        print("CLUSTER_PASSWORD variable not set")
        exit(1)

    cert_list = []
    # create the public cert chain
    public_certs = ["tls/cluster_cert.pem", "tls/ca_cert.pem"]

    for cert in public_certs:
        with open(cert) as file:
            cert_list.append(file.read())

    # private key
    with open("tls/cluster_key.pem") as file:
        key = file.read()

    req = {"name": "proxy"}
    req["certificate"] = "".join(cert_list)
    req["key"] = key

    resp = requests.put(
        url="https://" + CLUSTER_FQDN + ":9443/v1/cluster/update_cert",
        auth=HTTPBasicAuth(CLUSTER_USER, CLUSTER_PASSWORD),
        headers={
            "Content-Type": "application/json",
        },
        data=json.dumps(req),
        verify=False,
    )

    print(resp.content)


if __name__ == "__main__":
    main()
