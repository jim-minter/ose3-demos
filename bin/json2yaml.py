#!/usr/bin/python

import json
import sys
import yaml

def main():
    yaml.add_representer(unicode, lambda d, v: d.represent_scalar("tag:yaml.org,2002:str", v))
    print yaml.dump(json.loads(sys.stdin.read()), default_flow_style=False),


if __name__ == "__main__":
    main()
