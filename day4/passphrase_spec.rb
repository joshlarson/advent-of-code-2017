require_relative "passphrase"

describe :passphrase_valid? do
  [
    ["aa bb cc dd ee", true],
    ["aa bb cc dd aa", false],
    ["aa bb cc dd aaa", true],
  ].each do |passphrase, valid|
    it "'#{passphrase}' is #{valid ? "" : "not "}a valid passphrase" do
      expect(passphrase_valid?(passphrase)).to eq(valid)
    end
  end
end

describe :valid_passphrase_count do
  it "counts the number of valid passphrases in a string" do
    expect(
      valid_passphrase_count(
        "aa bb cc dd ee\naa bb cc dd aa\naa bb cc dd aaa"
      )
    ).to eq(2)
  end
end
