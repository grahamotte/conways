# crystal conway2.cr

class Board
  property :data, :size

  def initialize(size : Int32) : Nil
    @size = size
    @data = Hash(Tuple(Int32, Int32), Bool).new(default_value: false)
  end

  def get(p : Tuple(Int32, Int32)) : Bool
    @data[{p[0] % size, p[1] % size}]
  end

  def set(p : Tuple(Int32, Int32)) : Nil
    @data[{p[0] % size, p[1] % size}] = true
  end

  def active_locations : Array(Tuple(Int32, Int32))
    @data.keys.flat_map { |p| adj(p) }.+(@data.keys)
  end

  def neighbors(p : Tuple(Int32, Int32)) : Int32
    adj(p).map { |p| get(p) }.count { |x| x }
  end

  def to_s : String
    size.times.map do |r|
      size.times.map do |c|
        get({r, c}) ? '#' : '.'
      end.join(' ')
    end.join("\n")
  end

  private def adj(p : Tuple(Int32, Int32)) : Array(Tuple(Int32, Int32))
    [
      {p[0] + 0, p[1] + 1},
      {p[0] + 0, p[1] - 1},
      {p[0] + 1, p[1] + 0},
      {p[0] - 1, p[1] + 0},
      {p[0] + 1, p[1] + 1},
      {p[0] - 1, p[1] - 1},
      {p[0] + 1, p[1] - 1},
      {p[0] - 1, p[1] + 1},
    ]
  end
end

class Conway
  property :board

  def initialize(size : Int32) : Nil
    @board = Board.new(size)

    (size * size / 2).to_i.times do
      board.set({rand(0..size), rand(0..size)})
    end
  end

  def tick : Nil
    nb = Board.new(board.size)

    board.active_locations.each do |p|
      neih = board.neighbors(p)
      cell = board.get(p)
      nb.set(p) if neih == 3 || (neih == 2 && cell)
    end

    @board = nb
  end

  def to_s : String
    board.to_s
  end
end

s = 50
c = Conway.new(s)

100.times do
  print "\033[#{s}A"
  puts c.to_s
  c.tick
end
