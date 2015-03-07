#!/usr/bin/python

import argparse
import fcntl
import os
import requests
import struct
import textwrap


def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("--host", nargs="?", default="localhost")
    ap.add_argument("--port", nargs="?", default="4001")
    ap.add_argument("cmd", choices=["ls", "watch"])
    ap.add_argument("key", nargs="?", default="/")
    return ap.parse_args()


def get_winsize(fd=2):
    TIOCGWINSZ = 21523

    try:
        return struct.unpack("hh", fcntl.ioctl(fd, TIOCGWINSZ, "xxxx"))
    except:
        return (os.environ.get("LINES", 25), os.environ.get("COLUMNS", 80))


def ls(url, key, level=""):
    j = s.get(url + key).json()
    for node in sorted(j["node"].get("nodes", []), key=lambda n: n["key"]):
        print level + node["key"]
        if "dir" in node:
            ls(url, node["key"], level + "  ")
        else:
            print textwrap.fill(node["value"], winsize[1],
                                initial_indent=level + "  ",
                                subsequent_indent=level + "    ",
                                break_on_hyphens=False)


def main(args):
    global s
    s = requests.Session()

    global winsize
    winsize = get_winsize()

    if args.cmd == "ls":
        ls("http://%s:%s/v2/keys" % (args.host, args.port), args.key)
    else:
        watch("http://%s:%s/v2/keys%s?wait=true&recursive=true" % (args.host, args.port, args.key))


def watch(url):
    wi = ""
    while True:
        j = s.get(url + wi).json()
        print j["action"] + " " + j["node"]["key"]
        if "value" in j["node"]:
            print j["node"]["value"]
        print
        wi = "&waitIndex=%u" % (j["node"]["modifiedIndex"] + 1)


if __name__ == "__main__":
    main(parse_args())
