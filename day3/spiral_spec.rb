require_relative "spiral"

describe :coords_of do
  [
    [1, [0, 0]],
    [2, [1, 0]],
    [3, [1, 1]],
    [4, [0, 1]],
    [5, [-1, 1]],
    [6, [-1, 0]],
    [7, [-1, -1]],
    [8, [0, -1]],
    [13, [2, 2]],
    [20, [-2, -1]],
  ].each do |n, coords|
    it "puts #{n} at #{coords.inspect}" do
      expect(coords_of(n)).to eq(coords)
    end
  end
end

describe :manhattan_distance do
  [
    [1, 0],
    [12, 3],
    [23, 2],
    [6, 1],
    [1024, 31],
  ].each do |n, dist|
    it "#{n} is #{dist} squares away" do
      expect(manhattan_distance(n)).to eq(dist)
    end
  end
end
