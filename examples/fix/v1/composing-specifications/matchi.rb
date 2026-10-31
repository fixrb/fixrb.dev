require "fix"
require "matchi/fix"

Fix :Empty do
  on :empty? do
    it MUST be_true
  end
end

matcher = Matchi::Fix.new(:Empty)
matcher.to_s          # => "fix Empty"
matcher.match? { [] } # => true

Spectus.must(matcher).call { [nil] }.to_s # => "Failure: expected [nil] to fix Empty"
