# ruby conway2.rb

class Conway
  attr_accessor :board, :size

  def initialize(size)
    @size = size
    @board = (0..(size - 1)).map { (0..(size - 1)).map { [true, false].sample } }
  end

  def tick
    @board = begin
      board.map.with_index do |row, r|
        row.map.with_index do |col, c|
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
  end

  def to_s
    board.map do |row|
      row.map do |col|
        col ? '#' : '.'
      end.join(' ')
    end.join("\n")
  end
end

size = 50
conway = Conway.new(size)

100.times do
  print "\033[#{size}A"
  puts conway
  conway.tick
end
