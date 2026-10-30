require "fix"

Fix :Size do
  it MUST be_an_instance_of String

  on :size do
    it MUST eq 3
  end
end

results = Fix[:Size].run { "abcd" }
results.map(&:outcome) # => [:success, :failure]
results.map(&:passed?) # => [true, false]

result = results.last
result.location # => "examples/fix/results.rb:7"
result.chain    # => ".size"
result.summary  # => "expected 4 to eq 3"
result.to_s     # => "examples/fix/results.rb:7: Failure: expected 4 to eq 3"
result.result.class # => Spectus::Result

Fix[:Size].match? { "abc" } # => true
