// node conway.js

const size = 50;

const range = (n) => [...Array(n).keys()];

const mod = (n, m) => ((n % m) + m) % m;

var board = range(size).map((row) => {
  return range(size).map((col) => {
    return Math.random() < 0.5;
  });
});

var count;
const tick = (board) => {
  return board.map((row, r) => {
    return row.map((cell, c) => {
      count = 0;

      if (board[mod(r + 0, size)][mod(c + 1, size)]) count += 1;
      if (board[mod(r + 0, size)][mod(c - 1, size)]) count += 1;
      if (board[mod(r + 1, size)][mod(c + 0, size)]) count += 1;
      if (board[mod(r - 1, size)][mod(c + 0, size)]) count += 1;
      if (board[mod(r + 1, size)][mod(c + 1, size)]) count += 1;
      if (board[mod(r - 1, size)][mod(c - 1, size)]) count += 1;
      if (board[mod(r + 1, size)][mod(c - 1, size)]) count += 1;
      if (board[mod(r - 1, size)][mod(c + 1, size)]) count += 1;

      return count == 3 || (cell && count == 2);
    });
  });
};

const toS = (b) =>
  b.map((r) => r.map((c) => (c ? "●" : "·")).join(" ")).join("\n");

range(1000).forEach(() => {
  board = tick(board);
  process.stdout.write("\033" + `[${size}A`);
  console.log(toS(board));
});
