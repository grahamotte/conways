class Conway
  property board

  def initialize(size : Int32)
    @board = Array(Array(Bool)).new(size) { Array(Bool).new(size) { rand(0..1) == 1 } }
  end

  def tick
    @board = @board.map_with_index do |row, row_i|
      row.map_with_index do |cell, col_i|
        num_neighbors = live_neighbors(row_i, col_i)

        if cell
          [2, 3].includes?(num_neighbors)
        else
          num_neighbors == 3
        end
      end
    end

  end

  def to_s
    @board
      .map { |r| r.map { |c| c ? '#' : '.' }.join(' ') }
      .join("\n")
  end

  def live_neighbors(row, col)
    row = row % board.size
    col = col % board.size

    [
      board.dig?(row, col + 1),
      board.dig?(row, col - 1),
      board.dig?(row + 1, col),
      board.dig?(row - 1, col),
      board.dig?(row + 1, col + 1),
      board.dig?(row - 1, col - 1),
      board.dig?(row + 1, col - 1),
      board.dig?(row - 1, col + 1),
    ].count { |x| x }
  end
end

conway = Conway.new(20)

100.times do
  puts conway.to_s
  puts

  conway.tick
  sleep 0.1
end
