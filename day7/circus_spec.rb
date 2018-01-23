require_relative "circus"

describe Circus do
  let(:circus) { Circus.new }
  let(:tower) { circus.tower }

  context "single-node tower" do
    before(:each) do
      circus.add_node("a")
    end

    it "has the right label" do
      expect(tower.label).to eq("a")
    end

    it "has no children" do
      expect(tower.children).to be_empty
    end
  end

  context "tower with one child (child added first)" do
    before(:each) do
      circus.add_node("a")
      circus.add_node("b", "a")
    end

    it "has the right label" do
      expect(tower.label).to eq("b")
    end

    it "has a single child with the right label" do
      expect(tower.children.first.label).to eq("a")
    end
  end

  context "tower with one child (child added last)" do
    before(:each) do
      circus.add_node("b", "a")
      circus.add_node("a")
    end

    it "has the right label" do
      expect(tower.label).to eq("b")
    end

    it "has a single child with the right label" do
      expect(tower.children.first.label).to eq("a")
    end
  end

  context "tower with grandchildren" do
    before(:each) do
      circus.add_node("b", "a")
      circus.add_node("c")
      circus.add_node("a", "c")
    end

    it "has the right label" do
      expect(tower.label).to eq("b")
    end

    it "has a single child with the right label" do
      expect(tower.children.first.children.first.label).to eq("c")
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
