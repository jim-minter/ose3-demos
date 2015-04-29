#!/usr/bin/python

import argparse
import json
import os
import re
import requests
import socket
import tempfile


def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("host", nargs="?", default="localhost")
    ap.add_argument("port", nargs="?", default="4001")
    return ap.parse_args()


def update_etc_hosts(j):
    if j["action"] == "create":
        _update_etc_hosts(j["action"],
                          json.loads(j["node"]["value"])["host"])
    elif j["action"] == "delete":
        _update_etc_hosts(j["action"],
                          json.loads(j["prevNode"]["value"])["host"])


def _update_etc_hosts(action, hostname):
    print "%s %s" % (action, hostname)

    with open("/etc/hosts", "r") as f:
        lines = f.read().strip().split("\n")

    rx = re.compile(("^%s\s+%s$" % (ip, hostname)).replace(".", "\."))
    lines = [l for l in lines if not rx.match(l)]

    if action == "create":
        lines.append("%-13s %s" % (ip, hostname))

    f = tempfile.NamedTemporaryFile(dir="/etc", prefix="hosts.", delete=False)
    f.write("\n".join(lines) + "\n")
    f.close()

    os.chmod(f.name, 0644)
    os.rename(f.name, "/etc/hosts")


def watch(url, f):
    s = requests.Session()

    wi = "&waitIndex=1"
    while True:
        try:
            j = s.get(url + wi, cert=cert, verify=ca).json()
            f(j)
            wi = "&waitIndex=%u" % (j["node"]["modifiedIndex"] + 1)
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    args = parse_args()
    root = os.path.dirname(os.path.dirname(os.path.realpath(__file__))) + \
        "/openshift.local.certificates"
    cert = (root + "/master/etcd-client.crt", root + "/master/etcd-client.key")
    ca = root + "/ca/cert.crt"
    ip = socket.gethostbyname(args.host)
    watch("https://%s:%s/v2/keys/routes?wait=true&recursive=true" %
          (args.host, args.port), update_etc_hosts)
