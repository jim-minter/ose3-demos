#!/usr/bin/python

import os
import yaml

def main():
    y = yaml.load(open(os.environ["KUBECONFIG"], "r").read())

    print
    print "available contexts:"
    for ctx in sorted(y["contexts"], key=lambda ctx: ctx["name"]):
        ns = "/" + ctx["context"].get("namespace", "")
        if ns == "/":
            ns = ""

        print "  %-15s%s@%s%s" % (ctx["name"] + ": ", ctx["context"]["user"],
                                  ctx["context"]["cluster"], ns)

    print
    print "current context: %s" % y["current-context"]

if __name__ == "__main__":
    main()
