require "set"

class MemoryStore
  attr_reader :banks

  def initialize(banks)
    @banks = banks
  end

  def largest_index
    max = banks.reduce { |max, bank| bank > max ? bank : max }
    banks.find_index(max)
  end

  def step
    new_banks = []
    giving_index = largest_index
    banks.each_with_index do |bank, i|
      new_banks.push(i == giving_index ? 0 : bank)
    end

    banks[giving_index].times do |i|
      receiving_index = (1 + giving_index + i) % banks.size
      new_banks[receiving_index] += 1
    end

    MemoryStore.new(new_banks)
  end
end

class MemoryWalker
  include Enumerable

  def initialize(banks)
    @banks = banks
  end

  def each
    store = MemoryStore.new(@banks)
    loop do
      yield store.banks
      store = store.step
    end
  end
end

def find_memory_leak(input)
  already_seen = Set.new

  MemoryWalker.new(input.split.map(&:to_i)).find_index do |banks|
    result = already_seen.include?(banks)
    already_seen.add(banks)
    result
  end
end
