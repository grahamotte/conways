// rustc conway.rs && ./conway

const RANDOM: &str = "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";
const SIZE: usize = 20;

fn new_board() -> Vec<Vec<bool>> {
  let bools: Vec<bool> = RANDOM.as_bytes().into_iter().map(|x| x % 2 == 0).collect();
  let mut board: Vec<Vec<bool>> = Vec::new();
  let mut line: Vec<bool>;

  for r in 0..SIZE {
    line = Vec::new();
    for c in 0..SIZE { line.push(bools[SIZE * r + c]) }
    board.push(line)
  }

  return board;
}

fn render_line(line: Vec<bool>) -> String {
  return line
    .into_iter()
    .map(|y| if y { "# " } else { ". " })
    .collect::<Vec<&str>>()
    .join("")
}

// fn render(board: Vec<Vec<bool>>) -> String {
//   return board
//     .into_iter()
//     .map(|x| )
//     .collect::<String>()
//     // .join("")
// }

fn main() {
  println!("{:?}", render_line(new_board()[2]));
}
