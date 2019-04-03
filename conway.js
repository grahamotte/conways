const range = n => {
  return [...Array(n).keys()];
};

const randRange = max => Math.floor(Math.random() * (max + 1));

const boardToString = board => {
  return board
    .map(row => {
      return row
        .map(col => {
          return col ? "#" : ".";
        })
        .join(" ");
    })
    .join("\n");
};

const neighbors = (board, row, col) => {
  return [
    boardDig(board, row + 0, col + 1),
    boardDig(board, row + 0, col - 1),
    boardDig(board, row + 1, col + 0),
    boardDig(board, row - 1, col + 0),
    boardDig(board, row + 1, col + 1),
    boardDig(board, row - 1, col - 1),
    boardDig(board, row + 1, col - 1),
    boardDig(board, row - 1, col + 1)
  ].filter(x => x).length;
};

const boardDig = (board, row, col) => {
  row = row % board.length;
  col = col % board.length;

  try {
    return board[row][col];
  } catch {
    return false;
  }
};

const tick = board => {
  return board.map((row, row_index) => {
    return row.map((cell, col_index) => {
      count_neighbors = neighbors(board, row_index, col_index);

      if (cell) {
        return count_neighbors == 2 || count_neighbors == 3;
      } else {
        return count_neighbors == 3;
      }

      return false;
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

var board = range(size).map(row => {
  return range(size).map(col => {
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
