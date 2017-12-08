module ArrayReplace
  refine Array do
    def replace_at(index, item)
      result = []
      each_with_index do |e, i|
        if i == index
          result.push(item)
        else
          result.push(e)
        end
      end
      result
    end
  end
end

class Maze
  using ArrayReplace

  attr_reader :instructions, :pointer

  def initialize(instructions, pointer)
    @instructions = instructions
    @pointer = pointer
  end

  def step(&block)
    instruction = instructions[pointer]
    Maze.new(
      instructions.replace_at(pointer, block.call(instruction)),
      pointer + instruction
    )
  end

  def in_maze?
    (0..instructions.size-1).include?(pointer)
  end
end

class MazeWalker
  include Enumerable

  def initialize(instructions, &block)
    @block = block
    @instructions = instructions
  end

  def each
    maze = Maze.new(@instructions, 0)
    loop do
      yield maze
      maze = maze.step(&@block)
    end
  end
end

def escape_time_helper(input, &block)
  instructions = input.split("\n").map(&:to_i)
  MazeWalker
    .new(instructions, &block)
    .find_index { |maze| !maze.in_maze? }
end

def escape_time(input)
  escape_time_helper(input) { |i| i + 1 }
end

def wacky_escape_time(input)
  escape_time_helper(input) do |i|
    i >= 3 ? i - 1 : i + 1
  end
end
