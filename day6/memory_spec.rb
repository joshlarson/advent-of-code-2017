require_relative "memory"

describe MemoryStore do
  describe "#largest_index" do
    it "finds the largest block" do
      expect(MemoryStore.new([0, 2, 7, 0]).largest_index).to eq(2)
    end

    it "uses the earlier one in the case of a tie" do
      expect(MemoryStore.new([7, 2, 7, 0]).largest_index).to eq(0)
    end
  end

  describe "#step" do
    it "distributes the largest bank's blocks between the others" do
      expect(MemoryStore.new([0, 2, 7, 0]).step.banks).to eq([2, 4, 1, 2])
      expect(MemoryStore.new([2, 4, 1, 2]).step.banks).to eq([3, 1, 2, 3])
    end
  end
end

describe :find_memory_leak do
  it "works" do
    expect(find_memory_leak("0 2 7 0")).to eq(5)
  end
end

describe :memory_leak_size do
  it "works" do
    expect(memory_leak_size("0 2 7 0")).to eq(4)
  end
end
