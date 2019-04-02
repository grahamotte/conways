class Conway
  attr_accessor :board

  def initialize(size)
    @board = Array.new(size) { Array.new(size) { rand(0..1) == 1 } }
  end

  def tick
    @board = @board.map.with_index do |row, row_i|
      row.map.with_index do |cell, col_i|
        num_neighbors = live_neighbors(row_i, col_i)

        if cell
          [2, 3].include?(num_neighbors)
        else
          num_neighbors == 3
        end
      end
    end
  end

  def to_s
    board
      .map { |r| r.map { |c| c ? '#' : '.' }.join(' ') }
      .join("\n")
  end

  private

  def live_neighbors(row, col)
    row = row % board.size
    col = col % board.size

    [
      board.dig(row, col + 1),
      board.dig(row, col - 1),
      board.dig(row + 1, col),
      board.dig(row - 1, col),
      board.dig(row + 1, col + 1),
      board.dig(row - 1, col - 1),
      board.dig(row + 1, col - 1),
      board.dig(row - 1, col + 1),
    ].count { |x| x }
  end
end

conway = Conway.new(20)

100.times do
  puts conway
  puts

  conway.tick
  sleep 0.1
end
