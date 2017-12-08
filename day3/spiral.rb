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

class Range
  def extend_to(c)
    lower = c < self.first ? c : self.first
    upper = c > self.last ? c : self.last
    (lower..upper)
  end
end

def spiral(n)
  x = y = 0
  x_range = y_range = (0..0)
  direction = RIGHT

  (2..n).map do |i|
    unless y_range.include?(y)
      y_range = y_range.extend_to(y)
      direction = ROTATIONS[direction]
    end
    unless x_range.include?(x)
      x_range = x_range.extend_to(x)
      direction = ROTATIONS[direction]
    end
    x, y = direction[x, y]
  end

  [x, y]
end

def coords_of(n)
  spiral(n)
end

def abs(n)
  n < 0 ? -n : n
end

def manhattan_distance(n)
  x, y = spiral(n)
  abs(x) + abs(y)
end
