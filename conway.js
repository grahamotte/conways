// node conway.js

const range = (n) => {
  return [...Array(n).keys()];
};

const randRange = (max) => Math.floor(Math.random() * (max + 1));

const boardToString = (board) => {
  return board
    .map((row) => {
      return row
        .map((col) => {
          return col ? "#" : ".";
        })
        .join(" ");
    })
    .join("\n");
};

const liveOrDie = (board, row, col) => {
  countNeighbors = [
    board[mod(row + 0, board.length)][mod(col + 1, board.length)],
    board[mod(row + 0, board.length)][mod(col - 1, board.length)],
    board[mod(row + 1, board.length)][mod(col + 0, board.length)],
    board[mod(row - 1, board.length)][mod(col + 0, board.length)],
    board[mod(row + 1, board.length)][mod(col + 1, board.length)],
    board[mod(row - 1, board.length)][mod(col - 1, board.length)],
    board[mod(row + 1, board.length)][mod(col - 1, board.length)],
    board[mod(row - 1, board.length)][mod(col + 1, board.length)],
  ].filter((x) => x).length;

  if (board[row][col]) {
    return countNeighbors == 2 || countNeighbors == 3;
  } else {
    return countNeighbors == 3;
  }
};

const mod = (a, b) => {
  const r = a % b;
  return r < 0 ? r + b : r;
};

const tick = (board) => {
  return board.map((row, row_index) => {
    return row.map((cell, col_index) => {
      return liveOrDie(board, row_index, col_index);
    });
  });
};

function sleep(ms, callback) {
  var start = new Date().getTime();
  var expire = start + ms;

  while (new Date().getTime() < expire) {}

  callback(ms);
}

const size = 20;

var board = range(size).map((row) => {
  return range(size).map((col) => {
    return randRange(1) == 1;
  });
});

range(100).forEach((acc, val) => {
  sleep(100, () => {
    console.log(boardToString(board));
    console.log("");
    board = tick(board);
  });
});
