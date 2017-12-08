require_relative "memory"

puts find_memory_leak(File.read("banks.in"))
puts memory_leak_size(File.read("banks.in"))
