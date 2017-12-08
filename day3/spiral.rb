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
