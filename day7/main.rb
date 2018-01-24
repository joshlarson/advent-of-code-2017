require_relative "circus"

input = File.read("circus.in")

puts circus_root(input)
puts balancing_weight(input)
