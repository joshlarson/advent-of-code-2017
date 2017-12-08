def passphrase_valid?(passphrase, &block)
  words = passphrase.split(" ")
  words.map { |a| words.map { |b| [a, b] } }
    .reduce { |full, list| full + list }
    .count(&block) == words.count
end

def valid_passphrase_count(input, &block)
  input.split("\n")
    .count { |line| passphrase_valid?(line, &block) }
end

def exact_valid_passphrase_count(input)
  valid_passphrase_count(input) { |a, b| a == b }
end
