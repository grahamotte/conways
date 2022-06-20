# crystal conway.cr

class Conway
  property :board, :size

  def initialize(size : Int32)
    @size = size
    @board = Array(Array(Bool)).new(size) { Array(Bool).new(size) { [true, false].sample } }
  end

  def tick
    @board = board.map_with_index do |row, r|
      row.map_with_index do |col, c|
        count = 0
        count += 1 if board[(r + 0) % size][(c + 1) % size]
        count += 1 if board[(r + 0) % size][(c - 1) % size]
        count += 1 if board[(r + 1) % size][(c + 0) % size]
        count += 1 if board[(r - 1) % size][(c + 0) % size]
        count += 1 if board[(r + 1) % size][(c + 1) % size]
        count += 1 if board[(r - 1) % size][(c - 1) % size]
        count += 1 if board[(r + 1) % size][(c - 1) % size]
        count += 1 if board[(r - 1) % size][(c + 1) % size]

        count == 3 || (col && count == 2)
      end
    end
  end

  def to_s
    board.map do |row|
      row.map do |col|
        col ? '●' : '·'
      end.join(' ')
    end.join("\n")
  end
end

size = 50
conway = Conway.new(size)

start = Time.local
print "\e[?25l"
1000.times do
  print "\033[#{size}A"
  puts conway.to_s
  conway.tick
end
print "\e[?25h"
puts (Time.local - start).to_f
