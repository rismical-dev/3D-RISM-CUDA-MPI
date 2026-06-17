#!/usr/bin/env python3

import sys
import glob


def get_lambda_files(base, suffix):
    """
    base-1-* や base-2-* を探し、
    [(lambda, filename), ...]
    を lambda 昇順で返す
    """

    pattern = f"{base}-{suffix}-*"
    files = glob.glob(pattern)

    data = []

    for fname in files:
        try:
            lam = float(fname.split(f"-{suffix}-")[-1])
            data.append((lam, fname))
        except ValueError:
            pass

    data.sort(key=lambda x: x[0])

    return data

def integrate_series(filelist):

    if len(filelist) == 0:
        raise RuntimeError("No files found.")

    pl = 0.0
    summation = None
    b = None

    for lam, fname in filelist:

        with open(fname) as f:
            a = [float(line.strip()) for line in f]

        if summation is None:
            n = len(a)
            summation = [0.0] * n
            b = [0.0] * n

        if len(a) != len(summation):
            raise RuntimeError(
                f"Inconsistent file length: {fname}"
            )

        dl = lam - pl

        for i in range(len(a)):
            summation[i] += (a[i] + b[i]) * dl * 0.5

        pl = lam
        b = a

    return summation


def main():

    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} basename")
        sys.exit(1)

    base = sys.argv[1]

    files1 = get_lambda_files(base, 1)
    files2 = get_lambda_files(base, 2)

    if len(files1) == 0:
        raise RuntimeError(f"No files found matching {base}-1-*")

    sum1 = integrate_series(files1)

    if files2:
        sum2 = integrate_series(files2)
    else:
        sum2 = [0.0] * len(sum1)

    for s1, s2 in zip(sum1, sum2):
        print(f"{s1+s2:.15e} {s1:.15e} {s2:.15e}")


if __name__ == "__main__":
    main()
