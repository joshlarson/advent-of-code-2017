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
end

class Circus
  def initialize
    @towers = {}
  end

  def add_node(label, *child_labels)
    tower = find_or_create_tower(label)
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

def circus_root(input)
  circus = Circus.new
  input.split("\n").each do |line|
    label, weight, arrow, *children = line.split
    circus.add_node(label, *children.join.split(","))
  end

  circus.tower.label
end
