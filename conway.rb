# ruby conway.rb

class Conway
  attr_accessor :board

  def initialize(size)
    @board = Array.new(size) { Array.new(size) { rand(0..1) == 1 } }
  end

  def tick
    @board = board.map.with_index do |row, row_i|
      row.map.with_index do |_, col_i|
        live_or_die(row_i, col_i)
      end
    end
  end

  def to_s
    board.map { |r| r.map { |c| c ? '#' : '.' }.join(' ') }.join("\n")
  end

  private

  def live_or_die(row, col)
    neighbor_count = [
      board[(row + 0) % board.length][(col + 1) % board.length],
      board[(row + 0) % board.length][(col - 1) % board.length],
      board[(row + 1) % board.length][(col + 0) % board.length],
      board[(row - 1) % board.length][(col + 0) % board.length],
      board[(row + 1) % board.length][(col + 1) % board.length],
      board[(row - 1) % board.length][(col - 1) % board.length],
      board[(row + 1) % board.length][(col - 1) % board.length],
      board[(row - 1) % board.length][(col + 1) % board.length],
    ].count { |x| x }

    if board[row][col]
      [2, 3].include?(neighbor_count)
    else
      neighbor_count == 3
    end
  end
end

conway = Conway.new(20)

100.times do
  puts conway
  puts

  conway.tick
  sleep 0.1
end
