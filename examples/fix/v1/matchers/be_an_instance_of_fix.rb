require "fix"

Fix :Count do
  it MUST be_an_instance_of Integer
  it MUST be_an_instance_of Numeric
end

exit(Fix[:Count].test { 42 })
