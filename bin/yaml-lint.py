#!/usr/bin/python

import sys
import yaml


def dict_ordered_representer(dmp, d):
    start = ["kind", "apiVersion", "id", "metadata", "strategy", "source",
             "output", "type", "triggers", "parameters", "desiredState",
             "labels", "name", "description", "value", "version"]

    end = ["env"]

    value = []

    for k in start:
        if k in d:
            value.append((dmp.represent_data(k), dmp.represent_data(d[k])))

    for k in sorted(d):
        if k not in start + end:
            value.append((dmp.represent_data(k), dmp.represent_data(d[k])))

    for k in end:
        if k in d:
            value.append((dmp.represent_data(k), dmp.represent_data(d[k])))

    return yaml.MappingNode("tag:yaml.org,2002:map", value)


def main():
    yaml.add_representer(dict, dict_ordered_representer)
    print yaml.dump(yaml.load(sys.stdin.read()), default_flow_style=False),


if __name__ == "__main__":
    main()
