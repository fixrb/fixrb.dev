require "fix"

Fix :Count do
  it MUST be_a_kind_of Integer
  it MUST be_a_kind_of Numeric
  it MUST be_a_kind_of Comparable
  it MUST be_a_kind_of String
end

exit(Fix[:Count].test { 42 })
