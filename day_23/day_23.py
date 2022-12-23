#!/bin/python3

import sys
from collections import defaultdict

sys.setrecursionlimit(100000)

FILE = sys.argv[1] if len(sys.argv) > 1 else "input.txt"


def get_result(elves, to_print=False):
    min_y = min(elf[0] for elf in elves)
    min_x = min(elf[1] for elf in elves)

    max_y = max(elf[0] for elf in elves)
    max_x = max(elf[1] for elf in elves)

    count = 0

    for i in range(min_y, max_y + 1):
        for j in range(min_x, max_x + 1):
            if (i, j) in elves:
                if to_print:
                    print("#", end="")
            else:
                if to_print:
                    print(".", end="")
                count += 1
        if to_print:
            print("")
    if to_print:
        print("")

    return count


def part_one(elves, rounds):
    # In (Y, X)
    result = 0
    curr_elves = elves.copy()
    get_result(curr_elves)
    directions = ["N", "S", "W", "E"]

    for _ in range(rounds):
        moves = defaultdict(list)
        for elf in curr_elves:
            if not (
                any(
                    x in curr_elves
                    for x in [
                        (elf[0] - 1, elf[1]),
                        (elf[0] - 1, elf[1] - 1),
                        (elf[0] - 1, elf[1] + 1),
                        (elf[0] + 1, elf[1]),
                        (elf[0] + 1, elf[1] - 1),
                        (elf[0] + 1, elf[1] + 1),
                        (elf[0], elf[1] - 1),
                        (elf[0], elf[1] + 1),
                    ]
                )
            ):
                moves[(elf[0], elf[1])].append(elf)
                continue

            for d in directions:
                match d:
                    case "N":
                        # Check N/NE/NW
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0] - 1, elf[1]),
                                (elf[0] - 1, elf[1] - 1),
                                (elf[0] - 1, elf[1] + 1),
                            ]
                        ):
                            moves[(elf[0] - 1, elf[1])].append(elf)
                            break
                    case "S":
                        # Check S/SE/SW
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0] + 1, elf[1]),
                                (elf[0] + 1, elf[1] - 1),
                                (elf[0] + 1, elf[1] + 1),
                            ]
                        ):
                            moves[(elf[0] + 1, elf[1])].append(elf)
                            break
                    case "W":
                        # Check W/NW/SW
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0], elf[1] - 1),
                                (elf[0] - 1, elf[1] - 1),
                                (elf[0] + 1, elf[1] - 1),
                            ]
                        ):
                            moves[(elf[0], elf[1] - 1)].append(elf)
                            break
                    case "E":
                        # Check E/NE/SE:
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0], elf[1] + 1),
                                (elf[0] - 1, elf[1] + 1),
                                (elf[0] + 1, elf[1] + 1),
                            ]
                        ):
                            moves[(elf[0], elf[1] + 1)].append(elf)
                            break
            else:
                moves[(elf[0], elf[1])].append(elf)

        curr_elves = set()
        for (coord, desired) in moves.items():
            if len(desired) > 1:
                for d in desired:
                    curr_elves.add(d)
                continue
            else:
                curr_elves.add(coord)

        res = directions.pop(0)
        directions.append(res)

        result = get_result(curr_elves, False)

    return result


def part_two(elves):
    # In (Y, X)
    count = 0
    curr_elves = elves.copy()
    get_result(curr_elves)
    directions = ["N", "S", "W", "E"]
    prev = set()

    while prev != curr_elves:
        prev = curr_elves
        count += 1
        moves = defaultdict(list)
        for elf in curr_elves:
            if not (
                any(
                    x in curr_elves
                    for x in [
                        (elf[0] - 1, elf[1]),
                        (elf[0] - 1, elf[1] - 1),
                        (elf[0] - 1, elf[1] + 1),
                        (elf[0] + 1, elf[1]),
                        (elf[0] + 1, elf[1] - 1),
                        (elf[0] + 1, elf[1] + 1),
                        (elf[0], elf[1] - 1),
                        (elf[0], elf[1] + 1),
                    ]
                )
            ):
                moves[(elf[0], elf[1])].append(elf)
                continue

            for d in directions:
                match d:
                    case "N":
                        # Check N/NE/NW
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0] - 1, elf[1]),
                                (elf[0] - 1, elf[1] - 1),
                                (elf[0] - 1, elf[1] + 1),
                            ]
                        ):
                            moves[(elf[0] - 1, elf[1])].append(elf)
                            break
                    case "S":
                        # Check S/SE/SW
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0] + 1, elf[1]),
                                (elf[0] + 1, elf[1] - 1),
                                (elf[0] + 1, elf[1] + 1),
                            ]
                        ):
                            moves[(elf[0] + 1, elf[1])].append(elf)
                            break
                    case "W":
                        # Check W/NW/SW
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0], elf[1] - 1),
                                (elf[0] - 1, elf[1] - 1),
                                (elf[0] + 1, elf[1] - 1),
                            ]
                        ):
                            moves[(elf[0], elf[1] - 1)].append(elf)
                            break
                    case "E":
                        # Check E/NE/SE:
                        if all(
                            x not in curr_elves
                            for x in [
                                (elf[0], elf[1] + 1),
                                (elf[0] - 1, elf[1] + 1),
                                (elf[0] + 1, elf[1] + 1),
                            ]
                        ):
                            moves[(elf[0], elf[1] + 1)].append(elf)
                            break
            else:
                moves[(elf[0], elf[1])].append(elf)

        curr_elves = set()
        for (coord, desired) in moves.items():
            if len(desired) > 1:
                for d in desired:
                    curr_elves.add(d)
                continue
            else:
                curr_elves.add(coord)

        res = directions.pop(0)
        directions.append(res)

    return count


def main():
    print(f"Using file {FILE}")
    with open(FILE, "r", encoding="utf-8") as f:

        elves = set()
        for (row, line) in enumerate(f):
            line = line.strip("\n")
            for (col, l) in enumerate(line):
                if l == "#":
                    elves.add((row, col))

        print(f"Part one: {part_one(elves, 10)}")
        print(f"Part two: {part_two(elves)}")


main()
