require "matchi/fix"

Fix :Duck do
  on :walk do
    it MUST eq "Klop klop!"
  end
end

class Duck
  def walk = "Klop klop!"
end

matcher = Matchi::Fix.new(:Duck)
matcher.match? { Duck.new }  # => true
matcher.match? { "a decoy" } # => false
matcher.to_s                 # => "fix Duck"

Matchi::Fix.new { it MUST be_a_kind_of Numeric }.match? { 42 } # => true

Spectus.must(matcher).call { "a decoy" }.to_s # => "Failure: expected \"a decoy\" to fix Duck"
