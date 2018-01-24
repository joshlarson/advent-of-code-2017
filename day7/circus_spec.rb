require_relative "circus"

describe Circus do
  let(:circus) { Circus.new }
  let(:tower) { circus.tower }

  context "single-node tower" do
    before(:each) do
      circus.add_node("a", 5)
    end

    it "has the right label" do
      expect(tower.label).to eq("a")
    end

    it "has no children" do
      expect(tower.children).to be_empty
    end

    it "has the weight given" do
      expect(tower.total_weight).to eq(5)
    end

    it "is balanced" do
      expect(tower).to be_balanced
    end
  end

  context "tower with one child (child added first)" do
    before(:each) do
      circus.add_node("a", 5)
      circus.add_node("b", 7, "a")
    end

    it "has the right label" do
      expect(tower.label).to eq("b")
    end

    it "has a single child with the right label" do
      expect(tower.children.first.label).to eq("a")
    end

    it "has a weight that includes that of its children" do
      expect(tower.total_weight).to eq(12)
    end
  end

  context "tower with one child (child added last)" do
    before(:each) do
      circus.add_node("b", 7, "a")
      circus.add_node("a", 5)
    end

    it "has the right label" do
      expect(tower.label).to eq("b")
    end

    it "has a single child with the right label" do
      expect(tower.children.first.label).to eq("a")
    end

    it "has a weight that includes that of its children" do
      expect(tower.total_weight).to eq(12)
    end
  end

  context "tower with grandchildren" do
    before(:each) do
      circus.add_node("b", 5, "a")
      circus.add_node("c", 10)
      circus.add_node("a", 7, "c")
    end

    it "has the right label" do
      expect(tower.label).to eq("b")
    end

    it "has a single child with the right label" do
      expect(tower.children.first.children.first.label).to eq("c")
    end

    it "has a weight that includes that of its children" do
      expect(tower.total_weight).to eq(22)
    end
  end

  context "balanced tower with three children" do
    before(:each) do
      circus.add_node("a", 10)
      circus.add_node("b", 10)
      circus.add_node("c", 10)
      circus.add_node("d", 12, "a", "b", "c")
    end

    it "is balanced" do
      expect(tower).to be_balanced
    end
  end

  context "unbalanced tower with three children" do
    before(:each) do
      circus.add_node("a", 10)
      circus.add_node("b", 12)
      circus.add_node("c", 10)
      circus.add_node("d", 12, "a", "b", "c")
    end

    it "is not balanced" do
      expect(tower).not_to be_balanced
    end

    it "knows the balancing weight" do
      expect(tower.balancing_weight).to eq(10)
    end
  end

  context "unbalanced tower with the unbalanced node near the root" do
    before(:each) do
      circus.add_node("a", 10, "a1", "a2", "a3")
      circus.add_node("a1", 14)
      circus.add_node("a2", 14)
      circus.add_node("a3", 14)
      circus.add_node("b", 23, "b1", "b2", "b3")
      circus.add_node("b1", 8)
      circus.add_node("b2", 8)
      circus.add_node("b3", 8)
      circus.add_node("c", 1, "c1", "c2", "c3")
      circus.add_node("c1", 17)
      circus.add_node("c2", 17)
      circus.add_node("c3", 17)
      circus.add_node("x", 3, "a", "b", "c")
    end

    it "is not balanced" do
      expect(tower).not_to be_balanced
    end

    it "knows the balancing weight" do
      expect(tower.balancing_weight).to eq(28)
    end
  end

  context "unbalanced tower with the unbalanced node near the leaves" do
    before(:each) do
      circus.add_node("a", 10, "a1", "a2", "a3")
      circus.add_node("a1", 14)
      circus.add_node("a2", 14)
      circus.add_node("a3", 14)
      circus.add_node("b", 28, "b1", "b2", "b3")
      circus.add_node("b1", 8)
      circus.add_node("b2", 8)
      circus.add_node("b3", 8)
      circus.add_node("c", 1, "c1", "c2", "c3")
      circus.add_node("c1", 17)
      circus.add_node("c2", 18)
      circus.add_node("c3", 17)
      circus.add_node("x", 3, "a", "b", "c")
    end

    it "is not balanced" do
      expect(tower).not_to be_balanced
    end

    it "knows the balancing weight" do
      expect(tower.balancing_weight).to eq(17)
    end
  end
end

describe "circus_root" do
  it "works for a one-line tree" do
    input = <<-CIRCUS
a (5)
    CIRCUS

    expect(circus_root(input)).to eq("a")
  end

  it "works when there is one child" do
    input = <<-CIRCUS
a (5)
b (10) -> a
    CIRCUS

    expect(circus_root(input)).to eq("b")
  end

  it "works for the sample input" do
    input = <<-CIRCUS
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
    CIRCUS

    expect(circus_root(input)).to eq("tknk")
  end
end

describe "balancing_weight" do
  it "works for the sample input" do
    input = <<-CIRCUS
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
    CIRCUS

    expect(balancing_weight(input)).to eq(60)
  end
end
