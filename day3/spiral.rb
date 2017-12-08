RIGHT = -> x, y { [x + 1, y] }
UP = -> x, y { [x, y + 1] }
LEFT = -> x, y { [x - 1, y] }
DOWN = -> x, y { [x, y - 1] }

ROTATIONS = {
  RIGHT => UP,
  UP => LEFT,
  LEFT => DOWN,
  DOWN => RIGHT,
}

module RangeExtend
  refine Range do
    def extend_to(c)
      lower = c < self.first ? c : self.first
      upper = c > self.last ? c : self.last
      (lower..upper)
    end
  end
end

class Spiral
  include Enumerable
  using RangeExtend

  def each
    x = y = 0
    x_range = y_range = (0..0)
    direction = RIGHT

    loop do |i|
      unless y_range.include?(y)
        y_range = y_range.extend_to(y)
        direction = ROTATIONS[direction]
      end
      unless x_range.include?(x)
        x_range = x_range.extend_to(x)
        direction = ROTATIONS[direction]
      end
      yield x, y
      x, y = direction[x, y]
    end
  end
end

def coords_of(n)
  Spiral.new.take(n).last
end

def abs(n)
  n < 0 ? -n : n
end

def manhattan_distance(n)
  x, y = coords_of(n)
  abs(x) + abs(y)
end

module ArraySum
  refine Array do
    def sum
      self.reduce { |sum, n| sum + n }
    end
  end
end

class Grid
  using ArraySum

  def initialize
    @cells = {}
  end

  def cell_at(x, y)
    (
      @cells[x] || {}
    )[y] || 0
  end

  def set_cell(x, y, i)
    @cells[x] ||= {}
    @cells[x][y] = i
  end

  def sum_around(x, y)
    span = (-1..1)
    diffs = span.map { |dx| span.map { |dy| [dx, dy] } }
      .reduce { |full_list, list| full_list + list }
      .reject{ |dx, dy| [dx, dy] == [0, 0] }
      .map { |dx, dy| cell_at(x + dx, y + dy) }
      .sum
  end
end

class StressSpiral
  include Enumerable

  def each
    grid = Grid.new
    grid.set_cell(0, 0, 1)
    Spiral.new.each do |x, y|
      sum_around = [x, y] == [0, 0] ? 1 : grid.sum_around(x, y)
      yield sum_around
      grid.set_cell(x, y, sum_around)
    end
  end
end

def first_stress_greater_than(n)
  StressSpiral.new.find { |value| value > n }
end
