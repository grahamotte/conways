class Conway
  property board

  def initialize(size : Int32)
    @board = Array(Array(Bool)).new(size) { Array(Bool).new(size) { rand(0..1) == 1 } }
  end

  def tick
    @board = board.map_with_index do |row, row_i|
      row.map_with_index do |cell, col_i|
        live_or_die(row_i, col_i)
      end
    end

  end

  def to_s
    board
      .map { |r| r.map { |c| c ? '#' : '.' }.join(' ') }
      .join("\n")
  end

  def live_or_die(row, col)
    neighbor_count = [
      board[(row + 0) % board.size][(col + 1) % board.size],
      board[(row + 0) % board.size][(col - 1) % board.size],
      board[(row + 1) % board.size][(col + 0) % board.size],
      board[(row - 1) % board.size][(col + 0) % board.size],
      board[(row + 1) % board.size][(col + 1) % board.size],
      board[(row - 1) % board.size][(col - 1) % board.size],
      board[(row + 1) % board.size][(col - 1) % board.size],
      board[(row - 1) % board.size][(col + 1) % board.size],
    ].count { |x| x }

    if board[row][col]
      [2, 3].includes?(neighbor_count)
    else
      neighbor_count == 3
    end
  end
end

conway = Conway.new(20)

100.times do
  puts conway.to_s
  puts

  conway.tick
  sleep 0.1
end
