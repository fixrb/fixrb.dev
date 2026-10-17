require "matchi"

matcher = Matchi::Eq.new(42)
matcher.match? { 42 } # => true
matcher.match? { 41 } # => false
matcher.to_s          # => "eq 42"
