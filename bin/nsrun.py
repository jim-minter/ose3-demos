#!/usr/bin/python

import argparse
import collections
import ctypes
import errno
import os


def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("namespace", choices=["ipc", "mnt", "net", "pid", "uts"])
    ap.add_argument("command", nargs="?")
    ap.add_argument("-q", action="store_true")
    return ap.parse_args()


def get_command_line(pid):
    with open("/proc/%s/cmdline" % pid, "r") as f:
        cmdline = f.read().replace("\0", " ").strip()

    if not cmdline:
        with open("/proc/%s/comm" % pid, "r") as f:
            cmdline = "[%s]" % f.read().strip()

    return cmdline


def ps_namespaces(h):
    for ns in sorted(h.keys(), key=lambda ns: len(h[ns]), reverse=True):
        print ns
        for pid in h[ns]:
            print "%-6s%s" % (pid, get_command_line(pid))
        print


def enum_namespaces(namespace):
    h = collections.defaultdict(list)

    for pid in os.listdir("/proc"):
        if not pid.isdigit():
            continue

        try:
            ns_id = os.readlink("/proc/%s/ns/%s" % (pid, namespace))
        except OSError as e:
            if e.errno == errno.ENOENT:
                continue
            raise

        h[ns_id].append(pid)

    return h


def exec_namespaces(namespace, h, cmd, quiet=False):
    libc = ctypes.CDLL("libc.so.6", use_errno=True)

    myns = os.open("/proc/self/ns/%s" % namespace, os.O_RDONLY)

    for ns in sorted(h.keys(), key=lambda ns: len(h[ns]), reverse=True):
        if not quiet:
            print ns

        newns = os.open("/proc/%s/ns/%s" % (h[ns][0], namespace), os.O_RDONLY)
        libc.setns(newns, 0)
        os.system(cmd)
        libc.setns(myns, 0)
        os.close(newns)

        if not quiet:
            print

    os.close(myns)

if __name__ == "__main__":
    args = parse_args()
    h = enum_namespaces(args.namespace)
    if args.command:
        exec_namespaces(args.namespace, h, args.command, args.q)
    else:
        ps_namespaces(h)
