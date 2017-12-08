class Array
  def max
    self.reduce(self.first) { |max, x| x > max ? x : max }
  end

  def min
    self.reduce(self.first) { |min, x| x < min ? x : min }
  end

  def spread
    self.max - self.min
  end

  def sum
    self.reduce(0) { |sum, x| x + sum }
  end
end

def sum_over_lines(input, &block)
  input.split("\n")
    .map(&block)
    .sum
end

def checksum(input)
  sum_over_lines(input) do |row|
    row.split(" ").map(&:to_i).spread
  end
end

def checkmod(input)
  sum_over_lines(input) do |row|
    numbers = row.split(" ").map(&:to_i)
    pair = numbers
      .map { |x| numbers.map { |y| [x, y] } }
      .reduce([]) { |full_list, list| full_list + list }
      .find { |x, y| x % y == 0 && x != y }
    pair[0]/pair[1]
  end
end
