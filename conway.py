# python conway.py

import time
import random

class Conway:
    def __init__(self, size):
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
        length = len(self.board)
        neighbors = [
            self.board[(row + 0) % length][(col + 1) % length],
            self.board[(row + 0) % length][(col - 1) % length],
            self.board[(row + 1) % length][(col + 0) % length],
            self.board[(row - 1) % length][(col + 0) % length],
            self.board[(row + 1) % length][(col + 1) % length],
            self.board[(row - 1) % length][(col - 1) % length],
            self.board[(row + 1) % length][(col - 1) % length],
            self.board[(row - 1) % length][(col + 1) % length],
        ].count(True)

        if self.board[row][col]:
            return neighbors == 2 or neighbors == 3
        else:
            return neighbors == 3

    def __repr__(self):
        return "\n".join([
            ' '.join([
                '#' if cell else '.' for cell in row
            ]) for row in self.board
        ])

conway = Conway(20)

for _ in range(100):
    print(conway)
    print('')

    conway.tick()
    time.sleep(0.1)
