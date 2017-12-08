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

describe Grid do
  let(:grid) { Grid.new }

  it "starts out empty" do
    expect(grid.cell_at(0, 0)).to eq(0)
    expect(grid.cell_at(0, 5)).to eq(0)
    expect(grid.cell_at(5, 0)).to eq(0)
  end

  it "can be populated" do
    grid.set_cell(0, 5, 6)
    grid.set_cell(0, 3, 3)
    grid.set_cell(3, 2, 8)

    expect(grid.cell_at(0, 5)).to eq(6)
    expect(grid.cell_at(0, 3)).to eq(3)
    expect(grid.cell_at(3, 2)).to eq(8)
    expect(grid.cell_at(0, 0)).to eq(0)
  end

  it "can compute the sum_around" do
    grid.set_cell(0, 1, 4)
    grid.set_cell(2, 0, 3)

    expect(grid.sum_around(0, 0)).to eq(4)
    expect(grid.sum_around(1, 1)).to eq(7)
  end
end

describe StressSpiral do
  [
    [1, 1],
    [2, 1],
    [3, 2],
    [4, 4],
    [5, 5],
    [6, 10],
    [7, 11],
  ].each do |n, value|
    it "#{n} is populated with #{value}" do
      expect(StressSpiral.new.take(n).last).to eq(value)
    end
  end
end

describe :first_stress_greater_than do
  [
    [3, 4],
    [7, 10],
    [500, 747],
  ].each do |n, value|
    it "the first value greater than #{n} is #{value}" do
      expect(first_stress_greater_than(n)).to eq(value)
    end
  end
end
