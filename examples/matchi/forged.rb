require "matchi"

actual = "bar"

def actual.eql?(*)
  true
end

actual.eql?("foo") # => true

matcher = Matchi::Eq.new("foo")
matcher.match? { actual } # => false
