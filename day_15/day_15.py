#!/bin/python3

import sys

FILE = sys.argv[1] if len(sys.argv) > 1 else "input.txt"
Y = int(sys.argv[2]) if len(sys.argv) > 2 else 2000000
SEARCH = int(sys.argv[3]) if len(sys.argv) > 3 else 4000000


def distance(x, y, x2, y2):
    return abs(x - x2) + abs(y - y2)


def part_one(sensors, row):
    known = set((s[2], s[3]) for s in sensors)
    impossible = set()
    for sensor in sensors:
        (x, y, cx, cy) = sensor
        d = distance(x, y, cx, cy)

        curr_x = x
        dist = abs(y - row)
        while dist <= d:
            impossible.add((curr_x, row))
            curr_x -= 1
            dist += 1

        curr_x = x
        dist = abs(y - row)
        while dist <= d:
            impossible.add((curr_x, row))
            curr_x += 1
            dist += 1

    return len(impossible - known)


def part_two(sensors, max_val):
    for curr_y in range(max_val + 1):
        ranges = []
        for sensor in sensors:
            (x, y, cx, cy) = sensor
            d = distance(x, y, cx, cy)
            dist = abs(y - curr_y)

            whats_left = d - dist
            if whats_left >= 0:
                s = max(0, x - whats_left)
                e = min(max_val, x + whats_left)
                ranges.append((s, e))

        # We want to check if there's any value that doesn't touch!
        last_end = 0
        for (s, e) in sorted(ranges):
            if last_end >= s:
                last_end = max(last_end, e)
            else:
                return (last_end + 1) * 4000000 + curr_y


print("Using file {}, Y = {}, SEARCH = {}".format(FILE, Y, SEARCH))
with open(FILE, "r", encoding="utf-8") as f:
    state = []

    for line in f:
        line = line.strip().split(" ")
        x = int(line[2].split("=")[-1].split(",")[0])
        y = int(line[3].split("=")[-1].split(":")[0])

        closest_x = int(line[-2].split("=")[-1].split(",")[0])
        closest_y = int(line[-1].split("=")[-1])

        state.append((x, y, closest_x, closest_y))

    print("Part one: {}".format(part_one(state, Y)))
    print("Part two: {}".format(part_two(state, SEARCH)))
