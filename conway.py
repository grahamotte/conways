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
        wrap = lambda x: x % len(self.board)

        neighbors = [
            self.dig(self.board, wrap(row + 0), wrap(col + 1)),
            self.dig(self.board, wrap(row + 0), wrap(col - 1)),
            self.dig(self.board, wrap(row + 1), wrap(col + 0)),
            self.dig(self.board, wrap(row - 1), wrap(col + 0)),
            self.dig(self.board, wrap(row + 1), wrap(col + 1)),
            self.dig(self.board, wrap(row - 1), wrap(col - 1)),
            self.dig(self.board, wrap(row + 1), wrap(col - 1)),
            self.dig(self.board, wrap(row - 1), wrap(col + 1)),
        ].count(True)

        if self.dig(self.board, row, col):
            return neighbors == 2 or neighbors == 3
        else:
            return neighbors == 3

    def dig(self, items, *indexes):
        try:
            for index in indexes:
                items = items[index]
            return items
        except IndexError:
            return False

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
