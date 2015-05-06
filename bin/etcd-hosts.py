#!/usr/bin/python

import argparse
import json
import os
import re
import requests
import socket
import tempfile


class Hosts(object):
    def __init__(self):
        self.h = set()

    def write(self):
        with open("/etc/hosts", "r") as f:
            hosts = f.read()

        hosts = re.sub("\n# etcd-hosts begin\n.*# etcd-hosts end\n", "\n",
                       hosts, flags=re.S)

        f = tempfile.NamedTemporaryFile(dir="/etc", prefix="hosts.",
                                        delete=False)
        f.write(hosts)
        if self.h:
            f.write("# etcd-hosts begin\n")
            f.write("".join(["%-13s %s\n" % (ip, h) for h in self.h]))
            f.write("# etcd-hosts end\n")
        f.close()

        os.chmod(f.name, 0644)
        os.rename(f.name, "/etc/hosts")

    def add(self, x):
        print "create %s" % x
        self.h.add(x)

    def discard(self, x):
        print "delete %s" % x
        self.h.discard(x)


class RouteWatcher(object):
    def __init__(self, host, port, cert, ca):
        self.url = "https://%s:%s" % (host, port)
        (self.cert, self.ca) = (cert, ca)
        self.s = requests.Session()
        self.get_routes()

    def get(self, url):
        r = self.s.get(self.url + url, cert=self.cert, verify=self.ca)
        self.index = int(r.headers["X-Etcd-Index"])
        return r.json()

    def get_routes(self):
        j = self.get("/v2/keys/routes?recursive=true")

        if "node" in j:
            for domain in j["node"]["nodes"]:
                if "nodes" in domain:
                    hs = [json.loads(l["value"])["host"] \
                          for l in domain["nodes"]]
                    for h in hs:
                        hosts.add(h)

        hosts.write()

    def watch_routes(self):
        j = self.get("/v2/keys/routes?wait=true&recursive=true&waitIndex=%u" %
                     self.index)

        if j["action"] == "create":
            hosts.add(json.loads(j["node"]["value"])["host"])
            hosts.write()

        elif j["action"] == "delete":
            hosts.discard(json.loads(j["prevNode"]["value"])["host"])
            hosts.write()

        self.index = j["node"]["modifiedIndex"] + 1


def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("host", nargs="?", default="ose3-master.example.com")
    ap.add_argument("port", nargs="?", default="4001")
    return ap.parse_args()


def load_certs():
    root = os.path.dirname(os.path.dirname(os.path.realpath(__file__))) + \
        "/openshift.local.certificates"
    cert = (root + "/master/etcd-client.crt", root + "/master/etcd-client.key")
    ca = root + "/ca/cert.crt"

    return (cert, ca)


if __name__ == "__main__":
    args = parse_args()
    (cert, ca) = load_certs()
    ip = socket.gethostbyname(args.host)
    hosts = Hosts()
    rw = RouteWatcher(args.host, args.port, cert, ca)
    try:
        while True:
            rw.watch_routes()
    except KeyboardInterrupt:
        if hosts.h:
            hosts.h.clear()
            hosts.write()
