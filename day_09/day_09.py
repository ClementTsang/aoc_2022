#!/bin/python3

import sys

file = sys.argv[1] if len(sys.argv) > 1 else "input.txt"


def draw(snake, start, end):
    s = set(snake)
    for i in reversed(range(start, end)):
        for j in range(start, end):
            if (j, i) == (0, 0):
                print("0", end="")
            elif (j, i) in s:
                print("#", end="")
            else:
                print(".", end="")
        print("")
    print("")


def simulate(inst, size):
    # X, Y
    snake = []
    for _ in range(size):
        snake.append((0, 0))

    visited = set([(0, 0)])
    for (direction, amount) in inst:
        for _ in range(amount):
            match direction:
                case "U":
                    snake[0] = (snake[0][0], snake[0][1] + 1)
                case "D":
                    snake[0] = (snake[0][0], snake[0][1] - 1)
                case "R":
                    snake[0] = (snake[0][0] + 1, snake[0][1])
                case "L":
                    snake[0] = (snake[0][0] - 1, snake[0][1])
            for i in range(0, (size - 1)):
                if abs((snake[i][0] - snake[i + 1][0])) <= 1 and abs((snake[i][1] - snake[i + 1][1])) <= 1:
                    continue

                if snake[i][0] > snake[i + 1][0]:
                    snake[i + 1] = (snake[i + 1][0] + 1, snake[i + 1][1])
                elif snake[i][0] < snake[i + 1][0]:
                    snake[i + 1] = (snake[i + 1][0] - 1, snake[i + 1][1])

                if snake[i][1] > snake[i + 1][1]:
                    snake[i + 1] = (snake[i + 1][0], snake[i + 1][1] + 1)
                elif snake[i][1] < snake[i + 1][1]:
                    snake[i + 1] = (snake[i + 1][0], snake[i + 1][1] - 1)
            visited.add(snake[-1])
    return visited


with open(file) as f:
    inst = [(words[0], int(words[1])) for words in [line.split(" ") for line in f.readlines()]]

    print("Part 1: {}".format(len(simulate(inst, 2))))
    print("Part 2: {}".format(len(simulate(inst, 10))))
