require_relative "maze"

puts escape_time(File.read("input.maze"))
puts wacky_escape_time(File.read("input.maze"))
