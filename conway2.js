// node conway2.js

const board = {};

const get = (r, c) => board[`${r},${c}`];
const set = (r, c) => (board[`${r},${c}`] = true);
const locs = () => {
  return Object.keys(board).map((p) => p.split(",").map((x) => parseInt(x)));
};
const adj = (r, c) => {
  return [
    [r + 0, c + 1],
    [r + 0, c - 1],
    [r + 1, c + 0],
    [r - 1, c + 0],
    [r + 1, c + 1],
    [r - 1, c - 1],
    [r + 1, c - 1],
    [r - 1, c + 1],
  ];
};
const active = () => locs().flatMap((p) => adj(...p).concat([p]));

set(1, 1);
set(2, 2);

console.log(active());
