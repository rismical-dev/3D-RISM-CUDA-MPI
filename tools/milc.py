#!/usr/bin/env python3
import sys
import re

keys = ["SFE_SC", "SFE_SC_HNC", "SFE_GF", "PMV"]

coeff_sets = {
    "Sub": {
        "xmu":  [-0.718451957, 0.0, 1.62878139, 0.0],
        "xmu0": [5.19413792, 0.0, -3.58716288, -750.513679],
    },
    "HNC": {
        "xmu":  [0.0, 0.99554824, 0.0, 0.0],
        "xmu0": [0.0, 1.50999895, 0.0, -682.54621964],
    },
}

PMV_SCALE = 4184.0

def parse_xmu(filename):
    values = {}
    pattern = re.compile(r"^\s*(\w+)\s*=\s*([-\d\.Ee+]+)")
    with open(filename, "r") as f:
        for line in f:
            m = pattern.match(line)
            if m:
                key, val = m.group(1), float(m.group(2))
                if key in keys:
                    values[key] = val
                    if key == "PMV":
                        val *= PMV_SCALE
                    values[key] = val
    return values

def weighted_sum(values, coeffs):
    total = 0.0
    for k, c in zip(keys, coeffs):
        if k not in values:
            raise RuntimeError(f"{k} not found")
        total += c * values[k]
    return total

def main():
    if len(sys.argv) != 2:
        print("Usage: python milc.py [basename]")
        sys.exit(1)

    base = sys.argv[1]

    vals_xmu  = parse_xmu(f"{base}.xmu")
    vals_xmu0 = parse_xmu(f"{base}.xmu0")

    for set_name, coeff in coeff_sets.items():
        sum_xmu  = weighted_sum(vals_xmu,  coeff["xmu"])
        sum_xmu0 = weighted_sum(vals_xmu0, coeff["xmu0"])
        total    = sum_xmu + sum_xmu0

        print(f"== {set_name} ==")
#        print("xmu  contribution =", sum_xmu)
#        print("xmu0 contribution =", sum_xmu0)
        print("SFE(MILC)=", total, "(J/mol)")
        print("         =", total/4184, "(Kcal/mol)")
        print()

if __name__ == "__main__":
    main()
