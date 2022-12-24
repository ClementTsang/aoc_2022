#!/bin/python3

import sys

sys.setrecursionlimit(100000)

FILE = sys.argv[1] if len(sys.argv) > 1 else "input.txt"


def part_one(board, start, end, blizzards, walls):
    blizz = blizzards

    # Steps a blizzard forward.
    def get_blizzards():
        new_blizzards = []
        for b in blizz:
            pos = b[1]
            match b[0]:
                case ">":
                    pos = (pos[0], pos[1] + 1)
                case "<":
                    pos = (pos[0], pos[1] - 1)
                case "^":
                    pos = (pos[0] - 1, pos[1])
                case "v":
                    pos = (pos[0] + 1, pos[1])

            if pos in walls:
                match b[0]:
                    case ">":
                        pos = (pos[0], 1)
                    case "<":
                        pos = (pos[0], len(board[0]) - 2)
                    case "^":
                        pos = (len(board) - 2, pos[1])
                    case "v":
                        pos = (1, pos[1])

            new_blizzards.append((b[0], pos))
        return new_blizzards

    states = {start}
    time = 0
    while end not in states:
        time += 1

        new_states = set()
        blizz = get_blizzards()
        blizzard_set = set(b for (_, b) in blizz)
        for curr in states:
            pot = {
                (curr[0] + dy, curr[1] + dx)
                for (dy, dx) in [(0, 1), (0, -1), (1, 0), (-1, 0), (0, 0)]
            }
            new_states |= pot - blizzard_set - walls

        states = new_states

    return (time, blizz)


def part_two(board, start, end, blizzards, walls):
    (a, blizzards) = part_one(board, start, end, blizzards, walls)
    (b, blizzards) = part_one(board, end, start, blizzards, walls)
    (c, blizzards) = part_one(board, start, end, blizzards, walls)

    return a + b + c


def main():
    print(f"Using file {FILE}")
    with open(FILE, "r", encoding="utf-8") as f:

        start = (0, 0)
        end = (0, 0)
        board = []
        for line in f:
            line = line.strip()
            b = []
            for c in line:
                b.append(c)
            board.append(b)

        for (i, c) in enumerate(board[0]):
            if c == ".":
                start = (0, i)

        for (i, c) in enumerate(board[-1]):
            if c == ".":
                end = (len(board) - 1, i)

        blizzards = []
        walls = set()
        for (i, row) in enumerate(board):
            for (j, cell) in enumerate(row):
                if cell in [">", "<", "v", "^"]:
                    blizzards.append((cell, (i, j)))
                elif cell == "#":
                    walls.add((i, j))
        walls.add((-1, start[1]))
        walls.add((end[0] + 1, end[1]))

        print(f"Part one: {part_one(board, start, end, blizzards, walls)[0]}")
        print(f"Part two: {part_two(board, start, end, blizzards, walls)}")


main()
