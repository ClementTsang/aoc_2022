#!/bin/python3

import sys
import re

sys.setrecursionlimit(100000)

FILE = sys.argv[1] if len(sys.argv) > 1 else "input.txt"


def part_one(input):
    ret = 0

    for i in input:
        s = 0
        for (itx, c) in enumerate(i.strip()[::-1]):
            place = 5**itx
            if c == "-":
                v = -1
            elif c == "=":
                v = -2
            else:
                v = int(c)
            s += place * v
        ret += s

    snafu = []
    while ret != 0:
        curr = ret % 5

        match curr:
            case 0:
                snafu.append("0")
                ret //= 5
            case 1:
                snafu.append("1")
                ret -= 1
                ret //= 5
            case 2:
                snafu.append("2")
                ret -= 2
                ret //= 5
            case 3:
                snafu.append("=")
                ret += 2
                ret //= 5
            case 4:
                snafu.append("-")
                ret += 1
                ret //= 5

    return "".join(snafu[::-1])


def part_two():
    return "We're done!"


def main():
    print(f"Using file {FILE}")
    with open(FILE, "r", encoding="utf-8") as f:
        input = f.readlines()

        print(f"Part one: {part_one(input)}")
        print(f"Part two: {part_two()}")


main()
