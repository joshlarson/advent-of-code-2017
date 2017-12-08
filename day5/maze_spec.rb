require_relative "maze"

describe Maze do
  it "can view instructions and pointer" do
    maze = Maze.new([0], 0)

    expect(maze.instructions).to eq([0])
    expect(maze.pointer).to eq(0)
  end

  it "increments the instruction at the pointer" do
    maze = Maze.new([0], 0)

    expect(maze.step.instructions).to eq([1])
  end

  it "moves the pointer based on the instruction" do
    maze = Maze.new([1], 0)

    expect(maze.step.pointer).to eq(1)
  end

  it "knows whether the pointer is in the maze" do
    expect(Maze.new([0], 0)).to be_in_maze
    expect(Maze.new([0], 1)).not_to be_in_maze
    expect(Maze.new([0, 0], 1)).to be_in_maze
    expect(Maze.new([0, 0], -1)).not_to be_in_maze
  end
end

describe :escape_time do
  [
    ["0", 2],
    ["0\n3\n0\n1\n-3", 5],
  ].each do |input, time|
    it "'#{input.inspect}' is escaped in #{time} steps" do
      expect(escape_time(input)).to eq(time)
    end
  end
end
