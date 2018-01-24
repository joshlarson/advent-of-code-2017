class Tower
  attr_reader :children, :label

  def initialize(label)
    @label = label
    @children = []
    @is_child = false
  end

  def add_child(child)
    children << child
    child.child!
  end

  def child!
    @is_child = true
  end

  def root?
    !@is_child
  end

  def total_weight
    @weight + children.reduce(0) { |weight, child| weight + child.total_weight }
  end

  def weight=(weight)
    @weight = weight
  end

  def balanced?
    children
      .map(&:total_weight)
      .uniq
      .size <= 1
  end

  def common_weight
    children
      .map(&:total_weight)
      .group_by { |x| x }
      .map { |weight, arr| [weight, arr.size] }
      .find { |_, count| count > 1 }[0]
  end

  def balancing_weight
    children
      .find { |child| child.total_weight != common_weight }
      .balance_to(common_weight)
  end

  def balance_to(new_weight)
    balance_by_offset(new_weight - total_weight)
  end

  def balance_by_offset(offset)
    return offset + @weight if balanced?

    children.find { |child| child.total_weight != common_weight }.balance_by_offset(offset)
  end
end

class Circus
  def initialize
    @towers = {}
  end

  def add_node(label, weight, *child_labels)
    tower = find_or_create_tower(label)
    tower.weight = weight

    child_labels.each do |child_label|
      child = find_or_create_tower(child_label)
      tower.add_child(child)
    end
  end

  def tower
    @towers.values.find(&:root?)
  end

  private

  def find_or_create_tower(label)
    @towers[label] ||= Tower.new(label)
  end
end

def build_tower(input)
  circus = Circus.new
  input.split("\n").each do |line|
    label, weight, arrow, *children = line.split
    circus.add_node(label, weight[1..-2].to_i, *children.join.split(","))
  end

  circus.tower
end

def circus_root(input)
  build_tower(input).label
end

def balancing_weight(input)
  build_tower(input).balancing_weight
end
