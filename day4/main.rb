require_relative "passphrase"

puts exact_valid_passphrase_count(File.read("data.in"))
puts anagram_valid_passphrase_count(File.read("data.in"))
