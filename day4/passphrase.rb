def passphrase_valid?(passphrase)
  words = passphrase.split(" ").sort
  words[0..-2].zip(words[1..-1])
    .none? { |a, b| a == b }
end

def valid_passphrase_count(input)
  input.split("\n")
    .count { |line| passphrase_valid?(line) }
end
