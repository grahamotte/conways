// gcc -o conway conway.c && ./conway

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

bool ** newBoard(int size) {
  srand((unsigned) time(NULL));

  bool ** board = (bool **) malloc(size * sizeof(bool *));

  for (int r = 0; r < size; r++) {
    board[r] = (bool *) malloc(size * sizeof(bool));
  }

  return board;
}

void printBoard(bool ** board, int size) {
  for (int r = 0; r < size; r++) {
    for (int c = 0; c < size; c++) {
      if(board[r][c]) {
        printf("● ");
      } else {
        printf("· ");
      }
    }
    printf("\n");
  }
}

int mod(int a, int b) {
    int r = a % b;
    return r < 0 ? r + b : r;
}

int liveOrDie(bool ** board, int size, int row, int col) {
  int countNeighbors = 0;

  countNeighbors += (bool) board[mod(row + 0, size)][mod(col + 1, size)];
  countNeighbors += (bool) board[mod(row + 0, size)][mod(col - 1, size)];
  countNeighbors += (bool) board[mod(row + 1, size)][mod(col + 0, size)];
  countNeighbors += (bool) board[mod(row - 1, size)][mod(col + 0, size)];
  countNeighbors += (bool) board[mod(row + 1, size)][mod(col + 1, size)];
  countNeighbors += (bool) board[mod(row - 1, size)][mod(col - 1, size)];
  countNeighbors += (bool) board[mod(row + 1, size)][mod(col - 1, size)];
  countNeighbors += (bool) board[mod(row - 1, size)][mod(col + 1, size)];

  if (board[row][col]) {
    return countNeighbors == 2 || countNeighbors == 3;
  } else {
    return countNeighbors == 3;
  }
}

bool ** tick(bool ** board, int size) {
  bool ** updatedBoard = newBoard(size);

  for (int r = 0; r < size; r++) {
    for (int c = 0; c < size; c++) {
      updatedBoard[r][c] = liveOrDie(board, size, r, c);
    }
  }

  return updatedBoard;
}

void sleep_ms(int ms)
{
  struct timespec ts;
  ts.tv_sec = ms / 1000;
  ts.tv_nsec = (ms % 1000) * 1000000;
  nanosleep(&ts, NULL);
}

int main() {
  time_t start;
  time_t end;
  int size = 50;

  bool ** board = newBoard(size);

  for (int r = 0; r < size; r++) {
    for (int c = 0; c < size; c++) {
      board[r][c] = rand() % 2 == 0;
    }
  }

  // printf("\e[?25l");
  // fflush(stdout);

  time(&start);
  for (int i = 0; i < 1000; i++) {
    if (i != 0) {
      printf("\033[%dA\r", size);
      fflush(stdout);
    }

    printBoard(board, size);
    fflush(stdout);

    board = tick(board, size);
  }
  time(&end);

  printf("\n %f", difftime(end, start));

  // printf("\e[?25l");
  // fflush(stdout);
}
