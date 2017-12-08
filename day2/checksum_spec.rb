require_relative "checksum"

describe :checksum do
  [
    ["5 2", 3],
    ["5 9", 4],
    ["5 1 9 5", 8],
    ["7 5 3", 4],
    ["2 4 6 8", 6],
    ["5 3\n6 8", 4],
  ].each do |input, output|
    it "resolves #{input.inspect} to #{output}" do
      expect(checksum(input)).to eq(output)
    end
  end

  [
    ["5 2 6", 3],
    ["5 9 2 8", 4],
    ["9 4 7 3", 3],
    ["3 8 6 5", 2],
    ["5 2 6\n3 8 6 5", 5],
  ].each do |input, output|
    it "resolves #{input.inspect} to #{output}" do
      expect(checkmod(input)).to eq(output)
    end
  end
end
