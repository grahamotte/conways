# ruby conway2.rb

class Board
  attr_accessor :data, :size

  def initialize(size)
    @size = size
    @data = Hash.new { false }
  end

  def get(r, c)
    @data[[r % size, c % size]]
  end

  def set(r, c)
    @data[[r % size, c % size]] = true
  end

  def active_locations
    @data.keys + @data.keys.map { |r, c| adj(r, c) }.flatten(1)
  end

  def neighbors(r, c)
    adj(r, c).map { |r, c| get(r, c) }.count { |x| x }
  end

  def to_s
    size.times.map do |r|
      size.times.map do |c|
        get(r, c) ? '#' : '.'
      end.join(' ')
    end.join("\n")
  end

  private

  def adj(r, c)
    [
      [r + 0, c + 1],
      [r + 0, c - 1],
      [r + 1, c + 0],
      [r - 1, c + 0],
      [r + 1, c + 1],
      [r - 1, c - 1],
      [r + 1, c - 1],
      [r - 1, c + 1],
    ]
  end
end

class Conway
  attr_accessor :board

  def initialize(size)
    @board = Board.new(size)

    (size * size / 2).times { board.set(rand(0..size), rand(0..size)) }
  end

  def tick
    nb = Board.new(board.size)

    board.active_locations.each do |r, c|
      neih = board.neighbors(r, c)
      cell = board.get(r, c)
      nb.set(r, c)if neih == 3 || (neih == 2 && cell)
    end

    @board = nb
  end

  def to_s
    board.to_s
  end
end

s = 50
c = Conway.new(s)

100.times do
  print "\033[#{s}A"
  puts c
  c.tick
end
