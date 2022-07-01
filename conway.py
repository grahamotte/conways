# python conway.py

import time
import random

class Conway:
    def __init__(self, size):
        self.size = size
        self.board = [
            [random.choice([True, False]) for x in range(size)]
            for x in range(size)
        ]

    def tick(self):
        self.board = [
            [self.live_or_die(row_i, cell_i) for cell_i, cell in enumerate(row)]
            for row_i, row in enumerate(self.board)
        ]

    def live_or_die(self, row, col):
        count = 0
        if self.board[(row + 0) % self.size][(col + 1) % self.size]: count += 1
        if self.board[(row + 0) % self.size][(col - 1) % self.size]: count += 1
        if self.board[(row + 1) % self.size][(col + 0) % self.size]: count += 1
        if self.board[(row - 1) % self.size][(col + 0) % self.size]: count += 1
        if self.board[(row + 1) % self.size][(col + 1) % self.size]: count += 1
        if self.board[(row - 1) % self.size][(col - 1) % self.size]: count += 1
        if self.board[(row + 1) % self.size][(col - 1) % self.size]: count += 1
        if self.board[(row - 1) % self.size][(col + 1) % self.size]: count += 1

        if self.board[row][col]:
            return count == 2 or count == 3
        else:
            return count == 3

    def to_s(self):
        return "\n".join([
            ' '.join([
                '●' if cell else '·' for cell in row
            ]) for row in self.board
        ])

size = 50
conway = Conway(size)
start = time.time()

for _ in range(1000):
    print(f"\033[{size + 1}A\r")
    print(conway.to_s())
    conway.tick()

print(time.time() - start)
