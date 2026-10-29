require "spectus"
require "matchi"

eq = Matchi::Eq.new(42)
requirement = Spectus.must(eq)
requirement.level  # => :MUST
requirement.negate # => false

result = requirement.call { 6 * 7 }
result.passed?     # => true
result.outcome     # => :success
result.actual      # => "42"
result.description # => "eq 42"
result.to_s        # => "Success: expected 42 to eq 42"

Spectus.must_not(eq).call { 42 }.to_s # => "Failure: expected 42 not to eq 42"
Spectus.should(eq).call { 2 }.to_s    # => "Warning: expected 2 to eq 42"
Spectus.must(eq).call { 1 / 0 }.to_s  # => "Error: ZeroDivisionError: divided by 0"
