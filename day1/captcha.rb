class String
  def rotate(n=1)
    first = self[0..(n-1)]
    second = self[n..-1]

    second + first
  end
end

def captcha(input)
  captcha_helper(input, 1)
end

def captcha_halfway(input)
  captcha_helper(input, input.size/2)
end

def captcha_helper(input, rotation)
  first = input.chars.map(&:to_i)
  second = input.rotate(rotation).chars.map(&:to_i)

  first.zip(second)
    .select { |x, y| x == y }
    .map { |x, _| x }
    .reduce(0) { |sum, x| sum + x }
end
