require_relative "passphrase"

describe :exact_valid_passphrase_count do
  [
    ["aa bb cc dd ee", 1],
    ["aa bb cc dd aa", 0],
    ["aa bb cc dd aaa", 1],
    ["aa bb cc dd ee\naa bb cc dd aa\naa bb cc dd aaa", 2]
  ].each do |input, count|
    it "'#{input.inspect}' has #{count} valid passphrase(s)" do
      expect(
        exact_valid_passphrase_count(input)
      ).to eq(count)
    end
  end
end
