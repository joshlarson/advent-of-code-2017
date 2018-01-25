require_relative "register"

describe Memory do
  let(:memory) { Memory.new }

  it "applies a single instruction" do
    memory.apply("a inc 1 if a == 0")

    expect(memory.value_at("a")).to eq(1)
  end

  it "applies multiple instructions" do
    memory.apply("a inc 1 if a == 0")
    memory.apply("a inc 2 if a >= 0")

    expect(memory.value_at("a")).to eq(3)
  end

  it "does not apply an instruction if the condition is not met" do
    memory.apply("a inc 1 if a > 0")

    expect(memory.value_at("a")).to eq(0)
  end

  it "decrements when appropriate" do
    memory.apply("a dec 1 if a >= 0")

    expect(memory.value_at("a")).to eq(-1)
  end

  it "applies the sample input" do
    memory.apply("b inc 5 if a > 1")
    memory.apply("a inc 1 if b < 5")
    memory.apply("c dec -10 if a >= 1")
    memory.apply("c inc -20 if c == 10")

    expect(memory.value_at("a")).to eq(1)
    expect(memory.value_at("b")).to eq(0)
    expect(memory.value_at("c")).to eq(-10)
  end

  it "can find the largest register value" do
    memory.apply("b inc 5 if a > 1")
    memory.apply("a inc 1 if b < 5")
    memory.apply("c dec -10 if a >= 1")
    memory.apply("c inc -20 if c == 10")

    expect(memory.largest_register).to eq(1)
  end
end

describe "sample input" do
  let (:input) do
      input = <<-INPUT
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
      INPUT
  end

  describe "largest_register" do
    it "works" do
      expect(largest_register(input)).to eq(1)
    end
  end
end
